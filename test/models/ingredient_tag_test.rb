require "test_helper"

class IngredientTagTest < ActiveSupport::TestCase
  def setup
    @ingredient_tag = ingredient_tags(:one)
  end

  test "should be valid" do
    assert @ingredient_tag.valid?
  end

  test "should require an ingredient" do
    @ingredient_tag.ingredient = nil
    assert_not @ingredient_tag.valid?
  end

  test "should require a tag" do
    @ingredient_tag.tag = nil
    assert_not @ingredient_tag.valid?
  end

  test "should belong to ingredient" do
    assert_respond_to @ingredient_tag, :ingredient
  end

  test "should belong to tag" do
    assert_respond_to @ingredient_tag, :tag
  end

  test "should check unique ingredient and tag combination" do
    duplicate_ingredient_tag = @ingredient_tag.dup
    assert_not duplicate_ingredient_tag.valid?
  end

  test "should return the total records" do
    assert_equal 2, IngredientTag.count
  end
end
