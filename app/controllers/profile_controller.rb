class ProfileController < ApplicationController
  layout "profile"

  before_action :find_user, only: :update

  def index; end

  def update
    if user.update_attributes params_profile
      flash[:success] = "Update profile sucessful"
    else
      flash[:success] = "Update password sucessful"
    end
    redirect_to profile_index_path
  end

  def change_password; end

  def update_change_password
    current_user.current_password = params[:current_password]
    if current_user.update_attributes params_change_password
      sign_in(current_user, bypass: true)
      flash[:success] = "Update password sucessful"
      redirect_to profile_index_path
    else
      flash[:success] = "Update password sucessful"
      render :change_password
    end
  end

  private

  attr_reader :user

  def find_user
    @user = User.find_by id: params[:id]
    return if user

    flash[:warning] = "Cannot found user"
    redirect_to profile_index_path
  end

  def params_profile
    params.require(:user).permit :first_name, :last_name, :avatar
  end

  def params_change_password
    params.require(:user).permit :password, :password_confirmation
  end
end
