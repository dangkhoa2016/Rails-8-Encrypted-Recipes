require "application_system_test_case"
require "system_test_helper"

class IngredientRecipesTest < ApplicationSystemTestCase
  setup do
    @ingredient_recipe = ingredient_recipes(:one)
  end

  test "visiting the index" do
    visit ingredient_recipes_url
    assert_selector "h1", text: "Ingredient and Recipes"
  end

  test "should create ingredient recipe" do
    visit ingredient_recipes_url
    click_on "New ingredient recipe", match: :first, class: [ "btn", "btn-primary" ]

    fill_in "Amount", with: @ingredient_recipe.amount
    select("Ingredient 2", from: "ingredient_recipe[ingredient_id]")
    select("Recipe 1", from: "ingredient_recipe[recipe_id]")
    fill_in "Unit", with: @ingredient_recipe.unit + " new"
    click_on "Submit"

    assert_text "Ingredient recipe was successfully created"
    click_on "Back"
  end

  test "should update Ingredient recipe" do
    visit ingredient_recipe_url(@ingredient_recipe)
    click_on "Edit", match: :first, class: [ "btn", "btn-secondary" ]

    fill_in "Amount", with: @ingredient_recipe.amount
    select("Ingredient 2", from: "ingredient_recipe[ingredient_id]")
    select("Recipe 1", from: "ingredient_recipe[recipe_id]")
    fill_in "Unit", with: @ingredient_recipe.unit + " updated"
    click_on "Submit"

    assert_text "Ingredient recipe was successfully updated"
    click_on "Back"
  end

  test "should destroy Ingredient recipe" do
    visit ingredient_recipe_url(@ingredient_recipe)
    click_on "Destroy", match: :first
    within("div.modal-footer") do
      click_on "Yes"
    end

    assert_text /Ingredient recipe with Id: \[\d+\] was successfully destroyed/
  end
end
