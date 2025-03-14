class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :authenticate_user!
  layout :get_layout

  private

  helper_method def model_name
    controller_name.singularize
  end

  def get_layout
    if devise_controller? && !is_edit_profile?
      "devise"
    else
      "application"
    end
  end

  def is_edit_profile?
    controller_name == "registrations" && action_name.in?([ "edit", "update" ])
  end
end
