class ApplicationController < ActionController::Base
  include Pundit
  include ApplicationHelper

  protect_from_forgery prepend: true
  rescue_from Pundit::NotAuthorizedError, with: :authorized

  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  protected

  def configure_permitted_parameters
    added_attrs = [:first_name, :last_name, :email, :password, :password_confirmation]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
  end

  def authorized
    flash[:danger] = "Khong co quyen truy cap"
    redirect_to request.referer || (current_user ? current_user.root_path : root_path)
  end
end
