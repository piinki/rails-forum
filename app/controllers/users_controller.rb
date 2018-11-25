class UsersController < ApplicationController
	before_action :find_user, only: %i(viewban ban unban)

	def viewban
		store_location
	end

	def ban
		if @user.update_attributes user_params
			flash[:success] = t "user.messages.ban_success"
			redirect_back_or @user
		else
			flash[:warning] = t "user.messages.ban_fail"
			render :viewban
		end
	end

	def unban
		if @user.update_attributes expired_at: nil
			flash[:success] = t "user.messages.unban_success"
		else
			flash[:warning] = t "user.messages.unban_fail"
		end
		redirect_to request.referer
	end

	private

	attr_reader :user

	def find_user
    @user = User.find_by id: params[:id]
    return if user

    flash[:warning] = t "user.messages.not_found"
    redirect_to profile_index_path
  end

  def user_params
  	params.require(:user).permit :expired_at
  end
end
