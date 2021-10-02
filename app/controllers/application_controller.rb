class ApplicationController < ActionController::Base
before_action :configure_devise_permitted_parameters, if: :devise_controller?
rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

protected

  def configure_devise_permitted_parameters
    # Add columns into the allowed parameter for sign up action
    devise_parameter_sanitizer.permit(:sign_up, keys:[:first_name, :last_name,
      :prefix, :suffix, :position, :university_institute_company,:department,
      :contact_number, :city, :country, :admin, :isvsp2022_registered])
  end

  def after_sign_in_path_for(resource)
    static_pages_welcome_path
  end

  def render_unprocessable_entity_response(invalid)
    #render json: { errors: invalid.record.errors }, status: :unprocessable_entity
    redirect_to "/500.html" #404/422/500 -server error

    ExceptionNotifier.notify_exception(
      invalid,
      env: request.env, data: { message: 'was doing something wrong' }
    )
  end
end
