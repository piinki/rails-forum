class ProfileController < ApplicationController
  layout "profile"

  def index; end

  def change_password; end

  def update_change_password
    current_user.current_password = params[:current_password]
    if current_user.update_attributes params_change_password
      sign_in(current_user, bypass: true)
      flash[:success] = "Update password sucessful"
      redirect_to profile_index_path
    else
      flash[:warning] = "Cannot update password"
      render :change_password
    end
  end

  private

  def params_change_password
    params.require(:user).permit :password, :password_confirmation
  end
end
