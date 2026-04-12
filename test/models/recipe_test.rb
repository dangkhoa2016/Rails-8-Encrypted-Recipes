require "test_helper"

class RecipeTest < ActiveSupport::TestCase
  def setup
    @recipe = recipes(:one)
  end

  test "should be valid" do
    assert @recipe.valid?
  end

  test "should require a name" do
    @recipe.name = nil
    assert_not @recipe.valid?
  end

  test "should have many steps" do
    assert_respond_to @recipe, :steps
  end

  test "should have many ingredient_recipes" do
    assert_respond_to @recipe, :ingredient_recipes
  end

  test "should have many ingredients through ingredient_recipes" do
    assert_respond_to @recipe, :ingredients
  end

  test "ingredients through association returns correct records" do
    recipe = recipes(:one)
    ingredient = ingredients(:one)
    assert_includes recipe.ingredients, ingredient
  end

  test "tags through association returns correct records" do
    recipe = recipes(:one)
    tag = tags(:one)
    assert_includes recipe.tags, tag
  end

  test "should belong to category" do
    assert_respond_to @recipe, :category
  end

  test "should return the total records" do
    assert_equal 2, Recipe.count
  end
end
