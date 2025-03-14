require "application_system_test_case"
require "system_test_helper"

class CategoriesTest < ApplicationSystemTestCase
  setup do
    @category = categories(:one)
  end

  test "visiting the index" do
    visit categories_url
    assert_selector "h1", text: "Categories"
  end

  test "should create category" do
    visit categories_url
    click_on "New category", match: :first, class: [ "btn", "btn-primary" ]
    # find_link(class: ['btn', 'btn-primary'], text: 'New category').click

    fill_in "Name", with: @category.name + " new"
    fill_in "Summary", with: @category.summary
    click_on "Submit"

    assert_text "Category was successfully created"
    click_on "Back"
  end

  test "should update Category" do
    visit category_url(@category)
    click_on "Edit", match: :first, class: [ "btn", "btn-secondary" ]

    fill_in "Name", with: @category.name + " updated"
    fill_in "Summary", with: @category.summary
    click_on "Submit"

    assert_text "Category was successfully updated"
    click_on "Back"
  end

  test "should destroy Category" do
    visit category_url(@category)
    click_on "Destroy", match: :first
    within("div.modal-footer") do
      click_on "Yes"
    end

    assert_text /Category with Id: \[\d+\] was successfully destroyed/
  end
end
