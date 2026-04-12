class ActionDispatch::SystemTestCase
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in(users(:one))
  end
end
