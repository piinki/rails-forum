class SessionsController < Devise::SessionsController
  layout "login"

  def create
    if user_signed_in?

      binding.pry
      
      redirect_to managers_root_path
    else
      render :new
    end
  end
end
