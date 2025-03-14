require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get home_index_url
    assert_response :success

    assert_match '<h1 class="display-6 fw-bold">Recipe Dashboard</h1>', response.body, "Expected to have a title"
    assert_match "<!-- Widget 1: Categories -->", response.body, "Expected to have a categories widget"
    assert_match "<!-- Widget 2: Recipes -->", response.body, "Expected to have a recipes widget"
    assert_match "<!-- Widget 3: Tags -->", response.body, "Expected to have a tags widget"
    assert_match "<!-- Widget 4: Ingredients -->", response.body, "Expected to have an ingredients widget"
    assert_match '<p class="card-text">Total: <span id="categories-count">*</span></p>', response.body, "Expected to have a categories count"
    assert_match '<p class="card-text">Total: <span id="recipes-count">*</span></p>', response.body, "Expected to have a recipes count"
    assert_match '<p class="card-text">Total: <span id="tags-count">*</span></p>', response.body, "Expected to have a tags count"
    assert_match '<p class="card-text">Total: <span id="ingredients-count">*</span></p>', response.body, "Expected to have an ingredients count"
  end

  test "should fetch widgets and display counts of categories, recipes, tags, and ingredients using TurboStream" do
    get top_widgets_home_index_url, as: :turbo_stream
    assert_response :success

    assert_match '<turbo-stream action="update" target="categories-count">', response.body, "Expected to have a categories count"
    assert_match '<turbo-stream action="update" target="recipes-count">', response.body, "Expected to have a recipes count"
    assert_match '<turbo-stream action="update" target="tags-count">', response.body, "Expected to have a tags count"
    assert_match '<turbo-stream action="update" target="ingredients-count">', response.body, "Expected to have an ingredients count"
  end

  test "should fetch widgets and display counts of categories, recipes, tags, and ingredients using Xhr" do
    get top_widgets_home_index_url, as: :json
    assert_response :success

    assert_match '"categories":', response.body, "Expected to have a categories count"
    assert_match '"recipes":', response.body, "Expected to have a recipes count"
    assert_match '"tags":', response.body, "Expected to have a tags count"
    assert_match '"ingredients":', response.body, "Expected to have an ingredients count"
  end

  test "should fetch latest recipes using TurboStream" do
    get latest_recipes_home_index_url, as: :turbo_stream
    assert_response :success

    assert_match '<turbo-stream action="update" target="latest-recipes">', response.body, "Expected to have the latest recipes"
    assert_match '<td data-label="Recipe Name">', response.body, "Expected to have a recipe name"
    assert_match '<td data-label="Total Steps">', response.body, "Expected to have a total steps"
    assert_match '<td data-label="Calories">', response.body, "Expected to have calories"
    assert_match '<td data-label="Preparation Duration">', response.body, "Expected to have preparation duration"
  end

  test "should fetch latest recipes using Xhr" do
    get latest_recipes_home_index_url, as: :json
    assert_response :success

    assert_match '"category_id":', response.body, "Expected to have a category ID"
    assert_match '"name":', response.body, "Expected to have a recipe name"
    assert_no_match '"steps":', response.body, "Expected to not have total steps"
    assert_match '"calories":', response.body, "Expected to have calories"
    assert_match '"prepare_duration":', response.body, "Expected to have preparation duration"
  end

  test "should fetch ingredient_tags list using TurboStream" do
    get ingredient_tags_home_index_url, as: :turbo_stream
    assert_response :success

    assert_match '<turbo-stream action="update" target="ingredient-tags-list">', response.body, "Expected to have the ingredient tags"
    assert_match '<li class="list-group-item">', response.body, "Expected to have a list item"
    assert_match '<a href="/tags/', response.body, "Expected to have a tag link"
    assert_match "</a> (1 ingredient)", response.body, "Expected to have an ingredient by the tag count"
  end

  test "should fetch ingredient_tags list using Xhr" do
    get ingredient_tags_home_index_url, as: :json
    assert_response :success

    assert_match '"name":', response.body, "Expected to have a tag name"
    assert_no_match '"count":', response.body, "Expected to have an ingredient count by the tag"
    assert_match '"tag_type":"ingredient"', response.body, "Expected to have a tag type"
  end

  test "should fetch recipe_tags list using TurboStream" do
    get recipe_tags_home_index_url, as: :turbo_stream
    assert_response :success

    assert_match '<turbo-stream action="update" target="recipe-tags-list">', response.body, "Expected to have the recipe tags"
    assert_match '<li class="list-group-item">', response.body, "Expected to have a list item"
    assert_match '<a href="/tags/', response.body, "Expected to have a tag link"
    assert_match "</a> (1 recipe)", response.body, "Expected to have a recipe by the tag count"
  end

  test "should fetch recipe_tags list using Xhr" do
    get recipe_tags_home_index_url, as: :json
    assert_response :success

    assert_match '"name":', response.body, "Expected to have a tag name"
    assert_no_match '"count":', response.body, "Expected to have a recipe count by the tag"
    assert_match '"tag_type":"recipe"', response.body, "Expected to have a tag type"
  end

  test "should fetch top cuisines list using TurboStream" do
    get top_cuisines_home_index_url, as: :turbo_stream
    assert_response :success

    assert_match '<turbo-stream action="update" target="top-cuisines-list">', response.body, "Expected to have the top cuisines"
    assert_match '<li class="list-group-item">', response.body, "Expected to have a list item"
    assert_match '<a href="/recipes?cuisine=', response.body, "Expected to have a cuisine link"
    assert_match "</a> (1 recipe)", response.body, "Expected to have a recipe by the cuisine count"
  end

  test "should fetch top cuisines list using Xhr" do
    get top_cuisines_home_index_url, as: :json
    assert_response :success

    assert_match '"name":', response.body, "Expected to have a cuisine name"
    assert_match '"count":', response.body, "Expected to have a recipe count by the cuisine"
    assert_match '"slug":', response.body, "Expected to have a cuisine slug"
  end

  test "should get favicon.ico" do
    get "/favicon.ico"
    assert_response :success
  end

  test "should get favicon.png" do
    get "/favicon.png"
    assert_response :success
  end

  test "should get icon.svg" do
    get "/icon.svg"
    assert_response :success
  end

  test "should get robots.txt" do
    get "/robots.txt"
    assert_response :success
  end
end
