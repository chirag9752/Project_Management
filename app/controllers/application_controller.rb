class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception, unless: -> { request.format.json? }      # enable csrf protection
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :role, :employee_type, :password])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :role, :employee_type, :password])
  end
end