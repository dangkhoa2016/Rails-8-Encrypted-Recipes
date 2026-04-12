require "test_helper"

class RecipeTagTest < ActiveSupport::TestCase
  def setup
    @recipe_tag = recipe_tags(:one)
  end

  test "should be valid" do
    assert @recipe_tag.valid?
  end

  test "should require a recipe" do
    @recipe_tag.recipe = nil
    assert_not @recipe_tag.valid?
  end

  test "should require a tag" do
    @recipe_tag.tag = nil
    assert_not @recipe_tag.valid?
  end

  test "should belong to recipe" do
    assert_respond_to @recipe_tag, :recipe
  end

  test "should belong to tag" do
    assert_respond_to @recipe_tag, :tag
  end

  test "encrypted reference ids still resolve recipe and tag" do
    recipe_tag = RecipeTag.create!(recipe: recipes(:one), tag: tags(:two))

    raw_values = RecipeTag.connection.select_one(
      "SELECT recipe_id, tag_id FROM recipe_tags WHERE id = #{recipe_tag.id}"
    )

    refute_equal recipes(:one).id.to_s, raw_values["recipe_id"]
    refute_equal tags(:two).id.to_s, raw_values["tag_id"]
    assert_equal recipes(:one).id, recipe_tag.reload.recipe_id
    assert_equal tags(:two).id, recipe_tag.tag_id
    assert_equal recipes(:one), recipe_tag.recipe
    assert_equal tags(:two), recipe_tag.tag
  end

  test "should check unique recipe and tag combination" do
    duplicate_recipe_tag = @recipe_tag.dup
    assert_not duplicate_recipe_tag.valid?
  end

  test "should return the total records" do
    assert_equal 2, RecipeTag.count
  end
end
