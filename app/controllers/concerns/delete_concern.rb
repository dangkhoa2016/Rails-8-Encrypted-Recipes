module DeleteConcern
  include ActiveSupport::Concern

  # DELETE /[model]/1 or /[model]/1.json
  def destroy
    record = instance_variable_get("@#{model_name}")
    is_request_from_show_page = request.referrer == polymorphic_url(record)
    klass = model_name.classify.constantize

    if record.blank?
      message = "#{klass.model_name.human} with Id: [#{params[:id]}] not found"
      respond_to do |format|
        format.html do
          if turbo_frame_request?
            render plain: "<div class='alert alert-danger'>#{message}</div>".html_safe, status: :not_found
          else
            redirect_to polymorphic_path(controller_name), alert: message
          end
        end

        format.json { render json: { error: message }, status: :not_found }
      end

      return
    end

    begin
      record.destroy!

      tilte = "#{klass.model_name.human} with Id: [#{record.id}]"
      @success_message = "#{tilte} was successfully destroyed"
    rescue => error
      @error_message = error.message
    end

    respond_to do |format|
      format.html do
        if turbo_frame_request?
          render partial: "shared/destroy", formats: :turbo_stream, content_type: "text/vnd.turbo-stream.html"
        else
          if @error_message.present?
            redirect_to record, alert: @error_message
          else
            redirect_to polymorphic_path(controller_name), status: :see_other, notice: @success_message
          end
        end
      end

      format.json do
        if @error_message.present?
          render json: { error: @error_message }, status: :unprocessable_entity
        else
          render json: { notice: @success_message }, status: :ok
        end
      end
    end
  end
end
