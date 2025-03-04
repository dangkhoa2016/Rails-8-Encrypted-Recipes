require "test_helper"

class StepTest < ActiveSupport::TestCase
  def setup
    @step = steps(:one)
  end

  test "should be valid" do
    assert @step.valid?
  end

  test "should require a description" do
    @step.description = nil
    assert_not @step.valid?
  end

  test "should belong to recipe" do
    assert_respond_to @step, :recipe
  end

  test "should return the total records" do
    assert_equal 3, Step.count
  end
end
