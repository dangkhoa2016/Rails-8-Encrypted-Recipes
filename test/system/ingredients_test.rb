require "application_system_test_case"
require "system_test_helper"

class IngredientsTest < ApplicationSystemTestCase
  setup do
    @ingredient = ingredients(:one)
  end

  test "visiting the index" do
    visit ingredients_url
    assert_selector "h1", text: "Ingredients"
  end

  test "should create ingredient" do
    visit new_ingredient_url

    fill_in "Description", with: @ingredient.description
    fill_in "Name", with: @ingredient.name + " new"
    click_on "Submit"

    assert_text "Ingredient was successfully created"
    click_on "Back"
  end

  test "should update Ingredient" do
    visit edit_ingredient_url(@ingredient)

    fill_in "Description", with: @ingredient.description
    fill_in "Name", with: @ingredient.name + " updated"
    click_on "Submit"

    assert_text "Ingredient was successfully updated"
    click_on "Back"
  end

  test "should destroy Ingredient" do
    visit ingredient_url(@ingredient)
    click_on "Destroy"
    click_on "Yes"

    assert_text "Ingredient (#{@ingredient.id}) was successfully destroyed"
  end
end
