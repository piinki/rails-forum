class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true

  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action :authenticate_user!

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end


  protected

  def configure_permitted_parameters
    added_attrs = [:first_name, :last_name, :email, :password, :password_confirmation]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
  end
end
