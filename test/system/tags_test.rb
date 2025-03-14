require "application_system_test_case"
require "system_test_helper"

class TagsTest < ApplicationSystemTestCase
  setup do
    @tag = tags(:one)
  end

  test "visiting the index" do
    visit tags_url
    assert_selector "h1", text: "Tags"
  end

  test "should create tag" do
    visit tags_url
    click_on "New tag", match: :first, class: [ "btn", "btn-primary" ]

    fill_in "Name", with: @tag.name + " new"
    select("Ingredient", from: "tag[tag_type]")
    click_on "Submit"

    assert_text "Tag was successfully created"
    click_on "Back"
  end

  test "should update Tag" do
    visit tag_url(@tag)
    click_on "Edit", match: :first, class: [ "btn", "btn-secondary" ]

    fill_in "Name", with: @tag.name + " updated"
    select("Recipe", from: "tag[tag_type]")
    click_on "Submit"

    assert_text "Tag was successfully updated"
    click_on "Back"
  end

  test "should destroy Tag" do
    visit tag_url(@tag)
    click_on "Destroy", match: :first
    within("div.modal-footer") do
      click_on "Yes"
    end

    assert_text /Tag with Id: \[\d+\] was successfully destroyed/
  end
end
