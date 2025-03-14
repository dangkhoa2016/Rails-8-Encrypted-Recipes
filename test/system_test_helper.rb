
module SignInHelper
  def log_in_as(user, password: "password")
    visit new_user_session_path

    password ||= user.password
    fill_in "Email", with: user.email
    fill_in "Password", with: password
    click_button "Login"
    is_logged_in?
  end

  def is_logged_in?
    page.has_selector? "a.dropdown-item", text: "Sign out"
    page.has_selector? "a.dropdown-item", text: "Profile"
  end
end

class ActionDispatch::SystemTestCase
  include Devise::Test::IntegrationHelpers
  include ::SignInHelper

  setup do
    rand(10) > 6 ? log_in_as(users(:one)) : sign_in(users(:one))
  end
end
