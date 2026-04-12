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

  test "encrypted reference ids still resolve ingredient and tag" do
    ingredient_tag = IngredientTag.create!(ingredient: ingredients(:two), tag: tags(:one))

    raw_values = IngredientTag.connection.select_one(
      "SELECT ingredient_id, tag_id FROM ingredient_tags WHERE id = #{ingredient_tag.id}"
    )

    refute_equal ingredients(:two).id.to_s, raw_values["ingredient_id"]
    refute_equal tags(:one).id.to_s, raw_values["tag_id"]
    assert_equal ingredients(:two).id, ingredient_tag.reload.ingredient_id
    assert_equal tags(:one).id, ingredient_tag.tag_id
    assert_equal ingredients(:two), ingredient_tag.ingredient
    assert_equal tags(:one), ingredient_tag.tag
  end

  test "should check unique ingredient and tag combination" do
    duplicate_ingredient_tag = @ingredient_tag.dup
    assert_not duplicate_ingredient_tag.valid?
  end

  test "should return the total records" do
    assert_equal 2, IngredientTag.count
  end
end
