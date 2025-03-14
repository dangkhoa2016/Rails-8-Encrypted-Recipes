require "application_system_test_case"
require "system_test_helper"

class StepsTest < ApplicationSystemTestCase
  setup do
    @step = steps(:one)
  end

  test "visiting the index" do
    visit steps_url
    assert_selector "h1", text: "Steps"
  end

  test "should create step" do
    visit steps_url
    click_on "New step", match: :first, class: [ "btn", "btn-primary" ]

    fill_in "Description", with: @step.description
    fill_in "Name", with: @step.name + " new"
    select("Recipe 1", from: "step[recipe_id]")
    fill_in "Step number", with: @step.step_number
    click_on "Submit"

    assert_text "Step was successfully created"
    click_on "Back"
  end

  test "should update Step" do
    visit step_url(@step)
    click_on "Edit", match: :first, class: [ "btn", "btn-secondary" ]

    fill_in "Description", with: @step.description
    fill_in "Name", with: @step.name + " updated"
    select("Recipe 2", from: "step[recipe_id]")
    fill_in "Step number", with: @step.step_number
    click_on "Submit"

    assert_text "Step was successfully updated"
    click_on "Back"
  end

  test "should destroy Step" do
    visit step_url(@step)
    click_on "Destroy", match: :first
    within("div.modal-footer") do
      click_on "Yes"
    end

    assert_text /Step with Id: \[\d+\] was successfully destroyed/
  end
end
