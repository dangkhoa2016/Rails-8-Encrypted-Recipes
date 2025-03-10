require "test_helper"

class RecipesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @recipe = recipes(:one)
  end

  test "should get index" do
    get recipes_url
    assert_response :success
  end

  test "should get new" do
    get new_recipe_url
    assert_response :success
  end

  test "should create recipe" do
    assert_difference("Recipe.count") do
      recipe_params = {
        calories: @recipe.calories,
        category_id: @recipe.category_id,
        cuisine_type: @recipe.cuisine_type,
        is_vegetarian: @recipe.is_vegetarian,
        name: @recipe.name,
        prepare_duration: @recipe.prepare_duration,
        summary: @recipe.summary
      }

      post recipes_url, params: { recipe: recipe_params, tag_ids: Tag.first(2).pluck(:id) }
    end
    recipe = controller.instance_variable_get(:@recipe)
    assert_equal recipe.tags.count, 2
    assert_redirected_to recipe_url(recipe)
  end

  test "should show recipe" do
    get recipe_url(@recipe)
    assert_response :success
  end

  test "should get edit" do
    get edit_recipe_url(@recipe)
    assert_response :success
  end

  test "should update recipe" do
    recipe_params = {
      calories: @recipe.calories,
      category_id: @recipe.category_id,
      cuisine_type: @recipe.cuisine_type,
      is_vegetarian: @recipe.is_vegetarian,
      name: @recipe.name,
      prepare_duration: @recipe.prepare_duration,
      summary: @recipe.summary
    }
    patch recipe_url(@recipe), params: { recipe: recipe_params, tag_ids: Tag.first(2).pluck(:id) }
    assert_redirected_to recipe_url(@recipe)
  end

  test "should destroy recipe" do
    assert_difference("Recipe.count", -1) do
      delete recipe_url(@recipe)
    end

    assert_redirected_to recipes_url
  end

  test "should render add ingredient form using recipes/ingredient_form partial" do
    get add_ingredient_recipe_url(@recipe, ingredient_recipes_page: true)
    ingredient_recipe = controller.instance_variable_get :@ingredient_recipe
    assert_not_nil ingredient_recipe
    assert_equal ingredient_recipe.recipe_id, @recipe.id
    assert_equal ingredient_recipe.new_record?, true
    assert_response :success
    assert_match " action=\"/recipes/#{@recipe.id}/create_ingredient?ingredient_recipes_page=true\" ", response.body
    assert_match " method=\"post\">", response.body
    assert_match " data-disable-with=\"Submit\" ", response.body
  end

  test "should create ingredient recipe and render ingredient list using recipes/ingredient_list partial" do
    assert_difference("IngredientRecipe.count") do
      create_params = {
        ingredient_id: Ingredient.last.id,
        amount: 11,
        unit: "cup"
      }
      post create_ingredient_recipe_url(@recipe), params: { ingredient_recipe: create_params }, as: :turbo_stream
    end
    ingredient_recipe = controller.instance_variable_get :@ingredient_recipe
    assert_not_nil ingredient_recipe
    assert_equal ingredient_recipe.recipe_id, @recipe.id
    assert_equal ingredient_recipe.new_record?, false
    assert_match " class='list-group-item list-group-item-secondary d-flex justify-content-between column-gap-2'>", response.body
  end

  test "should create ingredient recipe and render ingredient list using ingredients/ingredient_list partial" do
    assert_difference("IngredientRecipe.count") do
      create_params = {
        ingredient_id: Ingredient.last.id,
        amount: 1,
        unit: "piece"
      }
      post create_ingredient_recipe_url(@recipe, ingredient_recipes_page: true), params: { ingredient_recipe: create_params }, as: :turbo_stream
    end
    ingredient_recipe = controller.instance_variable_get :@ingredient_recipe
    assert_not_nil ingredient_recipe
    assert_equal ingredient_recipe.recipe_id, @recipe.id
    assert_equal ingredient_recipe.new_record?, false
    assert_match '<span class="badge bg-warning-subtle border border-warning-subtle text-warning-emphasis rounded-pill">', response.body
  end

  test "should create ingredient recipe and redirect to the created ingredient recipe" do
    assert_difference("IngredientRecipe.count") do
      create_params = {
        ingredient_id: Ingredient.last.id,
        amount: 1.5,
        unit: "gram"
      }
      post create_ingredient_recipe_url(@recipe), params: { ingredient_recipe: create_params }
    end
    assert_redirected_to recipe_url(@recipe)
  end

  test "should display error message when ingredient id is missing" do
    create_params = {
      ingredient_id: nil,
      amount: 1.5,
      unit: "gram"
    }
    post create_ingredient_recipe_url(@recipe), params: { ingredient_recipe: create_params }
    assert_response :success
    assert_match "Ingredient must exist", response.body
  end

  test "should display error message when amount is missing" do
    create_params = {
      ingredient_id: Ingredient.last.id,
      amount: nil,
      unit: "gram"
    }
    post create_ingredient_recipe_url(@recipe), params: { ingredient_recipe: create_params }
    assert_response :success
    assert_equal controller.instance_variable_get(:@ingredient_recipe).errors.full_messages, [ "Amount is not a number" ]
  end

  test "should display error message when amount is not a number" do
    create_params = {
      ingredient_id: Ingredient.last.id,
      amount: "invalid",
      unit: "gram"
    }
    post create_ingredient_recipe_url(@recipe), params: { ingredient_recipe: create_params }
    assert_response :success
    assert_equal controller.instance_variable_get(:@ingredient_recipe).errors.full_messages, [ "Amount must be greater than 0" ]
  end

  test "should display error message when unit is missing" do
    create_params = {
      ingredient_id: Ingredient.last.id,
      amount: 1.5,
      unit: nil
    }
    post create_ingredient_recipe_url(@recipe), params: { ingredient_recipe: create_params }
    assert_response :success
    assert_equal controller.instance_variable_get(:@ingredient_recipe).errors.full_messages, [ "Unit can't be blank" ]
  end


  test "should render add step form using recipes/step_form partial" do
    get add_step_recipe_url(@recipe, steps_page: true)
    step = controller.instance_variable_get :@step
    assert_not_nil step
    assert_equal step.recipe_id, @recipe.id
    assert_equal step.new_record?, true
    assert_response :success
    assert_match " action=\"/recipes/#{@recipe.id}/create_step?steps_page=true\" ", response.body
    assert_match " method=\"post\">", response.body
    assert_match " data-disable-with=\"Submit\" ", response.body
  end

  test "should create step and render step list using recipes/step_list partial" do
    assert_difference("Step.count") do
      create_params = {
        name: "Step 1",
        description: "Step 1 description"
      }
      post create_step_recipe_url(@recipe), params: { step: create_params }, as: :turbo_stream
    end
    step = controller.instance_variable_get :@step
    assert_not_nil step
    assert_equal step.recipe_id, @recipe.id
    assert_equal step.new_record?, false
    assert_match "<li class='list-group-item d-flex justify-content-between column-gap-2 bg-transparent'>", response.body
  end

  test "should create step and render step list using ingredients/step_list partial" do
    assert_difference("Step.count") do
      create_params = {
        name: "Step 2",
        description: "Step 2 description"
      }
      post create_step_recipe_url(@recipe, steps_page: true), params: { step: create_params }, as: :turbo_stream
    end
    step = controller.instance_variable_get :@step
    assert_not_nil step
    assert_equal step.recipe_id, @recipe.id
    assert_equal step.new_record?, false
    assert_match '<span class="badge bg-warning rounded-pill">', response.body
  end

  test "should create step and redirect to the created step" do
    assert_difference("Step.count") do
      create_params = {
        name: "Step 3",
        description: "Step 3 description"
      }
      post create_step_recipe_url(@recipe), params: { step: create_params }
    end
    assert_redirected_to recipe_url(@recipe)
  end
end
