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
    visit ingredients_url
    click_on "New ingredient", match: :first, class: [ "btn", "btn-primary" ]

    fill_in "Description", with: @ingredient.description
    fill_in "Name", with: @ingredient.name + " new"
    click_on "Submit"

    assert_text "Ingredient was successfully created"
    click_on "Back"
  end

  test "should update Ingredient" do
    visit ingredient_url(@ingredient)
    click_on "Edit", match: :first, class: [ "btn", "btn-secondary" ]

    fill_in "Description", with: @ingredient.description
    fill_in "Name", with: @ingredient.name + " updated"
    click_on "Submit"

    assert_text "Ingredient was successfully updated"
    click_on "Back"
  end

  test "should destroy Ingredient" do
    visit ingredient_url(@ingredient)
    click_on "Destroy", match: :first
    within("div.modal-footer") do
      click_on "Yes"
    end

    assert_text /Ingredient with Id: \[\d+\] was successfully destroyed/
  end
end
