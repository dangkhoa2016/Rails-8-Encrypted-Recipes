module LoadRecordConcern
  extend ActiveSupport::Concern

  included do
    before_action :load_record, only: [ :show, :edit, :update, :destroy ]
  end

  private

  def load_record
    model_class = controller_name.classify.constantize rescue nil
    return if model_class.blank?

    record = model_class.find_by(id: params[:id])
    if record.blank?
      render "layouts/record_not_found", status: :not_found
      nil
    else
      instance_variable_set("@#{controller_name.singularize}", record)
    end
  end
end
