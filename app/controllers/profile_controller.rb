class ProfileController < ApplicationController
  layout "profile"

  before_action :find_user, only: :update

  def index; end

  def update
    if user.update_attributes params_profile
      flash[:success] = t "profile.messages.update_success"
    else
      flash[:warning] = t "profile.messages.update_fail"
    end
    redirect_to profile_index_path
  end

  def change_password; end

  def update_change_password
    current_user.current_password = params[:current_password]
    if current_user.update_attributes params_change_password
      sign_in(current_user, bypass: true)
      flash[:success] = t "profile.messages.update_password_success"
      redirect_to profile_index_path
    else
      flash[:warning] = t "profile.messages.update_password_fail"
      render :change_password
    end
  end

  private

  attr_reader :user

  def find_user
    @user = User.find_by id: params[:id]
    return if user

    flash[:warning] = t "user.messages.not_found"
    redirect_to profile_index_path
  end

  def params_profile
    params.require(:user).permit :first_name, :last_name, :avatar
  end

  def params_change_password
    params.require(:user).permit :password, :password_confirmation
  end
end
