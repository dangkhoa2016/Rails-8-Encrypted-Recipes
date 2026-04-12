require "test_helper"

class IngredientRecipeTest < ActiveSupport::TestCase
  def setup
    @ingredient_recipe = ingredient_recipes(:one)
  end

  test "should be valid" do
    assert @ingredient_recipe.valid?
  end

  test "should require an ingredient" do
    @ingredient_recipe.ingredient = nil
    assert_not @ingredient_recipe.valid?
  end

  test "should require a recipe" do
    @ingredient_recipe.recipe = nil
    assert_not @ingredient_recipe.valid?
  end

  test "should require an amount" do
    @ingredient_recipe.amount = nil
    assert_not @ingredient_recipe.valid?
  end

  test "should require a unit" do
    @ingredient_recipe.unit = nil
    assert_not @ingredient_recipe.valid?
  end

  test "should belong to ingredient" do
    assert_respond_to @ingredient_recipe, :ingredient
  end

  test "should belong to recipe" do
    assert_respond_to @ingredient_recipe, :recipe
  end

  test "encrypted reference ids still resolve ingredient and recipe" do
    ingredient_recipe = IngredientRecipe.create!(
      ingredient: ingredients(:one),
      recipe: recipes(:two),
      amount: 1.5,
      unit: "tbsp"
    )

    raw_values = IngredientRecipe.connection.select_one(
      "SELECT ingredient_id, recipe_id FROM ingredient_recipes WHERE id = #{ingredient_recipe.id}"
    )

    refute_equal ingredients(:one).id.to_s, raw_values["ingredient_id"]
    refute_equal recipes(:two).id.to_s, raw_values["recipe_id"]
    assert_equal ingredients(:one).id, ingredient_recipe.reload.ingredient_id
    assert_equal recipes(:two).id, ingredient_recipe.recipe_id
    assert_equal ingredients(:one), ingredient_recipe.ingredient
    assert_equal recipes(:two), ingredient_recipe.recipe
  end

  test "should check unique ingredient and recipe combination" do
    duplicate_ingredient_recipe = @ingredient_recipe.dup
    assert_equal duplicate_ingredient_recipe.valid?, false
  end

  test "should return the total records" do
    assert_equal 2, IngredientRecipe.count
  end
end
