require "application_system_test_case"
require "system_test_helper"

class RecipesTest < ApplicationSystemTestCase
  setup do
    @recipe = recipes(:one)
  end

  test "visiting the index" do
    visit recipes_url
    assert_selector "h1", text: "Recipes"
  end

  test "should create recipe" do
    visit recipes_url
    click_on "New recipe", match: :first, class: [ "btn", "btn-primary" ]

    fill_in "Calories", with: @recipe.calories
    select("Category 1", from: "recipe[category_id]")
    select("American", from: "recipe[cuisine_type]")
    check "Is vegetarian" if @recipe.is_vegetarian
    fill_in "Name", with: @recipe.name + " new"
    fill_in "Prepare duration", with: @recipe.prepare_duration
    fill_in "Summary", with: @recipe.summary
    click_on "Submit"

    assert_text "Recipe was successfully created"
    click_on "Back"
  end

  test "should update Recipe" do
    visit recipe_url(@recipe)
    click_on "Edit", match: :first, class: [ "btn", "btn-secondary" ]

    fill_in "Calories", with: @recipe.calories
    select("Category 2", from: "recipe[category_id]")
    select("Italian", from: "recipe[cuisine_type]")
    check "Is vegetarian" if @recipe.is_vegetarian
    fill_in "Name", with: @recipe.name + " updated"
    fill_in "Prepare duration", with: @recipe.prepare_duration
    fill_in "Summary", with: @recipe.summary
    click_on "Submit"

    assert_text "Recipe was successfully updated"
    click_on "Back"
  end

  test "should destroy Recipe" do
    visit recipe_url(@recipe)
    click_on "Destroy", match: :first
    within("div.modal-footer") do
      click_on "Yes"
    end

    assert_text /Recipe with Id: \[\d+\] was successfully destroyed/
  end
end
