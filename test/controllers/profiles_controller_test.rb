require "test_helper"
require "controller_test_helper"

class ProfilesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get profile_url
    assert_response :success
    assert_match "<h2>Your Profile</h2>", response.body
    assert_match "Account Created On", response.body
    assert_match '/users/edit">Edit Profile</a>', response.body
  end
end
