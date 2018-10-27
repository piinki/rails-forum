class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true
  before_action :set_locale
  # before_action :authenticate_user!

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
