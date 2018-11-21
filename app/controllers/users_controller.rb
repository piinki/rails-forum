class UsersController < ApplicationController
	before_action :find_user, only: %i(viewban ban unban)

	def viewban
		store_location
	end

	def ban
		if @user.update_attributes user_params
			flash[:success] = "User da duoc ban"
			redirect_back_or @user
		else
			flash[:warning] = "User het duoc ban"
			render :viewban
		end
	end

	def unban
		if @user.update_attributes expired_at: nil
			flash[:success] = "User het duoc ban"
		else
			flash[:warning] = "User ko the het ban"
		end
		redirect_to request.referer 
	end 

	private

	attr_reader :user

	def find_user
    @user = User.find_by id: params[:id]
    return if user

    flash[:warning] = "Cannot found user"
    redirect_to profile_index_path
  end

  def user_params
  	params.require(:user).permit :expired_at
  end
end
