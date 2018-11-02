module Managers
  class BaseController < ApplicationController
    layout "managers/layouts/application"
    before_action :authenticate_user!
    before_action :navigate_user

    private

    def navigate_user
      return if %w(moderator admin).include? current_user.role
      redirect_to current_user.root_path
    end
  end
end
