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
    visit new_tag_url

    fill_in "Name", with: @tag.name + " new"
    select("Ingredient", from: "tag[tag_type]")
    click_on "Submit"

    assert_text "Tag was successfully created"
    click_on "Back"
  end

  test "should update Tag" do
    visit edit_tag_url(@tag)

    fill_in "Name", with: @tag.name + " updated"
    select("Recipe", from: "tag[tag_type]")
    click_on "Submit"

    assert_text "Tag was successfully updated"
    click_on "Back"
  end

  test "should destroy Tag" do
    visit tag_url(@tag)
    click_on "Destroy"
    click_on "Yes"

    assert_text "Tag (#{@tag.id}) was successfully destroyed"
  end
end
