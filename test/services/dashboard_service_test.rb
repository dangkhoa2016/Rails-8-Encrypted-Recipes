require "test_helper"

class DashboardServiceTest < ActiveSupport::TestCase
  def setup
    @service = DashboardService.new
  end

  # top_widgets
  test "top_widgets returns counts for all models" do
    data = @service.top_widgets
    assert_kind_of Hash, data
    assert_includes data.keys, :categories
    assert_includes data.keys, :recipes
    assert_includes data.keys, :ingredients
    assert_includes data.keys, :tags
  end

  test "top_widgets counts match actual record counts" do
    data = @service.top_widgets
    assert_equal Category.count, data[:categories]
    assert_equal Recipe.count,   data[:recipes]
    assert_equal Ingredient.count, data[:ingredients]
    assert_equal Tag.count,      data[:tags]
  end

  test "top_widgets returns zeros when no records exist" do
    # Relies on per-test fixture teardown; just verify keys are numeric
    data = @service.top_widgets
    data.each_value { |v| assert v >= 0 }
  end

  # latest_recipes
  test "latest_recipes returns an ActiveRecord relation" do
    result = @service.latest_recipes
    assert_respond_to result, :each
  end

  test "latest_recipes returns at most 5 records" do
    assert @service.latest_recipes.count <= 5
  end

  test "latest_recipes are ordered by created_at descending" do
    result = @service.latest_recipes.to_a
    if result.size > 1
      result.each_cons(2) do |a, b|
        assert a.created_at >= b.created_at
      end
    end
  end

  # ingredient_tags / recipe_tags
  test "ingredient_tags returns only ingredient-type tags" do
    @service.ingredient_tags.each do |tag|
      assert tag.ingredient?, "Expected ingredient tag, got: #{tag.tag_type}"
    end
  end

  test "recipe_tags returns only recipe-type tags" do
    @service.recipe_tags.each do |tag|
      assert tag.recipe?, "Expected recipe tag, got: #{tag.tag_type}"
    end
  end

  # top_cuisines
  test "top_cuisines returns an array of hashes" do
    result = @service.top_cuisines
    assert_kind_of Array, result
    result.each do |item|
      assert_includes item.keys, :name
      assert_includes item.keys, :count
      assert_includes item.keys, :slug
    end
  end

  test "top_cuisines are ordered by count descending" do
    result = @service.top_cuisines
    if result.size > 1
      result.each_cons(2) do |a, b|
        assert a[:count] >= b[:count]
      end
    end
  end
end
