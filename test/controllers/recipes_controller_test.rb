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
      summary: @recipe.summary,
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
end
