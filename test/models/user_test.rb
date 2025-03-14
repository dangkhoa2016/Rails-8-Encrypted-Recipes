require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "should require an email address" do
    @user.email = nil
    assert_not @user.valid?
  end

  test "should require a password" do
    @user = User.new(email: @user.email)
    assert_not @user.valid?
  end

  test "should require password length to be at least 6 characters" do
    @user.password = "a" * 5
    assert_not @user.valid?
  end

  test "should return the total records" do
    assert_equal 2, User.count
  end
end
