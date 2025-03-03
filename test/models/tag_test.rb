require "test_helper"

class TagTest < ActiveSupport::TestCase
  def setup
    @tag = tags(:one)
  end

  test "should be valid" do
    assert @tag.valid?
  end

  test "should have many ingredient_tags" do
    assert_respond_to @tag, :ingredient_tags
  end

  test "should have many recipe_tags" do
    assert_respond_to @tag, :recipe_tags
  end

  test "should return the total records" do
    assert_equal 2, Tag.count
  end

  test "should not check unique name" do
    duplicate_tag = @tag.dup
    assert_equal duplicate_tag.valid?, true
  end
end
