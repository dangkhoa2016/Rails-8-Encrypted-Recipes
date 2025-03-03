require "application_system_test_case"

class IngredientRecipesTest < ApplicationSystemTestCase
  setup do
    @ingredient_recipe = ingredient_recipes(:one)
  end

  test "visiting the index" do
    visit ingredient_recipes_url
    assert_selector "h1", text: "Ingredient recipes"
  end

  test "should create ingredient recipe" do
    visit ingredient_recipes_url
    click_on "New ingredient recipe"

    fill_in "Amount", with: @ingredient_recipe.amount
    fill_in "Ingredient", with: @ingredient_recipe.ingredient_id
    fill_in "Recipe", with: @ingredient_recipe.recipe_id
    fill_in "Unit", with: @ingredient_recipe.unit
    click_on "Create Ingredient recipe"

    assert_text "Ingredient recipe was successfully created"
    click_on "Back"
  end

  test "should update Ingredient recipe" do
    visit ingredient_recipe_url(@ingredient_recipe)
    click_on "Edit this ingredient recipe", match: :first

    fill_in "Amount", with: @ingredient_recipe.amount
    fill_in "Ingredient", with: @ingredient_recipe.ingredient_id
    fill_in "Recipe", with: @ingredient_recipe.recipe_id
    fill_in "Unit", with: @ingredient_recipe.unit
    click_on "Update Ingredient recipe"

    assert_text "Ingredient recipe was successfully updated"
    click_on "Back"
  end

  test "should destroy Ingredient recipe" do
    visit ingredient_recipe_url(@ingredient_recipe)
    click_on "Destroy this ingredient recipe", match: :first

    assert_text "Ingredient recipe was successfully destroyed"
  end
end
