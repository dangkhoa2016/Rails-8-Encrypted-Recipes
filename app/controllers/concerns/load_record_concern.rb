module LoadRecordConcern
  extend ActiveSupport::Concern

  DEFAULT_ACTIONS = %w[show edit update destroy].freeze
  included do
    before_action :load_record
  end

  private

  def additional_actions_for_load_record
    []
  end

  def allowed_actions
    (DEFAULT_ACTIONS + additional_actions_for_load_record).uniq.map(&:to_s)
  end

  def load_record
    return if allowed_actions.exclude?(action_name)

    model_class = controller_name.classify.constantize rescue nil
    return if model_class.blank?

    record = model_class.find_by(id: params[:id])
    if record.blank?
      render "layouts/record_not_found", status: :not_found
      return
    else
      instance_variable_set("@#{controller_name.singularize}", record)
    end
  end
end
