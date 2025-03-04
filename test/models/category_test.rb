require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  def setup
    @category = categories(:one)
  end

  test "should be valid" do
    assert @category.valid?
  end

  test "should require a name" do
    @category.name = nil
    assert_not @category.valid?
  end

  test "should have many recipes" do
    assert_respond_to @category, :recipes
  end

  test "should return the total records" do
    assert_equal 2, Category.count
  end
end
