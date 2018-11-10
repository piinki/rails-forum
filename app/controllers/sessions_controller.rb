class SessionsController < Devise::SessionsController
  layout "login"

  def create
    if user_signed_in?
      redirect_to root_path
    else
      self.resource = resource_class.new(sign_in_params)
      render :new
    end
  end
end
