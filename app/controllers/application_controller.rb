class ApplicationController < ActionController::Base
before_action :configure_devise_permitted_parameters, if: :devise_controller?

  protected

  def configure_devise_permitted_parameters
    # Add columns into the allowed parameter for sign up action
    devise_parameter_sanitizer.permit(:sign_up, keys:[:first_name, :last_name,
      :prefix, :suffix, :position, :university_institute_company,:department,
      :contact_number, :admin, :isvsp2022_registered])
  end

  def after_sign_in_path_for(resource)
    static_pages_welcome_path
  end

end
