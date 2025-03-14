
module SignInHelper
  def log_in_as(user, password: "password")
    password ||= user.password
    post new_user_session_path, params: { user: { email: user.email, password: password } }
    assert_redirected_to root_path
  end
end

class ActionDispatch::IntegrationTest
  include ::SignInHelper
  include Devise::Test::IntegrationHelpers

  setup do
    rand(10) > 6 ? log_in_as(users(:one)) : sign_in(users(:two))
  end
end
