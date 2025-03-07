require "test_helper"

class IngredientRecipesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ingredient_recipe = ingredient_recipes(:one)
  end

  test "should get index" do
    get ingredient_recipes_url
    assert_response :success
  end

  test "should get new" do
    get new_ingredient_recipe_url
    assert_response :success
  end

  test "should create ingredient_recipe" do
    assert_difference("IngredientRecipe.count") do
      ingredient_recipe_params = {
        amount: @ingredient_recipe.amount,
        ingredient_id: @ingredient_recipe.ingredient_id,
        recipe_id: Recipe.last.id,
        unit: @ingredient_recipe.unit
      }
      post ingredient_recipes_url, params: { ingredient_recipe: ingredient_recipe_params }
    end

    assert_redirected_to ingredient_recipe_url(IngredientRecipe.last)
  end

  test "should show ingredient_recipe" do
    get ingredient_recipe_url(@ingredient_recipe)
    assert_response :success
  end

  test "should get edit" do
    get edit_ingredient_recipe_url(@ingredient_recipe)
    assert_response :success
  end

  test "should update ingredient_recipe" do
    ingredient_recipe_params = {
        amount: @ingredient_recipe.amount,
        ingredient_id: @ingredient_recipe.ingredient_id,
        recipe_id: Recipe.last.id,
        unit: @ingredient_recipe.unit
      }
    patch ingredient_recipe_url(@ingredient_recipe), params: { ingredient_recipe: ingredient_recipe_params }
    assert_redirected_to ingredient_recipe_url(@ingredient_recipe)
  end

  test "should destroy ingredient_recipe" do
    assert_difference("IngredientRecipe.count", -1) do
      delete ingredient_recipe_url(@ingredient_recipe)
    end

    assert_redirected_to ingredient_recipes_url
  end
end
