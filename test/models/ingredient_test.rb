require "test_helper"

class IngredientTest < ActiveSupport::TestCase
  def setup
    @ingredient = ingredients(:one)
  end

  test "should be valid" do
    assert @ingredient.valid?
  end

  test "should have many ingredient_tags" do
    assert_respond_to @ingredient, :ingredient_tags
  end

  test "should have many ingredient_recipes" do
    assert_respond_to @ingredient, :ingredient_recipes
  end

  test "should return the total records" do
    assert_equal 2, Ingredient.count
  end
end
