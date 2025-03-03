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

  test "should not require an amount" do
    @ingredient_recipe.amount = nil
    assert_equal @ingredient_recipe.valid?, true
  end

  test "should not require a unit" do
    @ingredient_recipe.unit = nil
    assert_equal @ingredient_recipe.valid?, true
  end

  test "should belong to ingredient" do
    assert_respond_to @ingredient_recipe, :ingredient
  end

  test "should belong to recipe" do
    assert_respond_to @ingredient_recipe, :recipe
  end

  test "should not check unique ingredient and recipe combination" do
    duplicate_ingredient_recipe = @ingredient_recipe.dup
    assert_equal duplicate_ingredient_recipe.valid?, true
  end

  test "should return the total records" do
    assert_equal 2, IngredientRecipe.count
  end
end
