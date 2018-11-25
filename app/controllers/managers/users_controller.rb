class Managers::UsersController < Managers::BaseController
  before_action :authorize_user, except: %i(index show)
  before_action :find_user, only: %i(show edit update destroy ban unban)

  def index
    @users = User.acceptable.page(params[:page]).per Settings.per_page.user
  end

  def show
    @topics = user.topics.with_deleted.page(params[:page]).per Settings.per_page.user
  end

  def edit
    @categories = Category.all
  end

  def update
    if user.update_attributes user_params
      flash[:success] = t "user.messages.change_permision_success"
      redirect_to managers_users_path
    else
      flash[:warning] = t "user.messages.change_permision_fail"
      render :edit
    end
  end

  def destroy
    if user.destroy
      flash[:success] = t "user.messages.delete_success"
    else
      flash[:warning] = t "user.messages.delete_fail"
    end
    redirect_to managers_users_path
  end

  def banned
    @users = User.banned.page(params[:page]).per Settings.per_page.user
  end

  def deleted
    @users = User.only_deleted.page(params[:page]).per Settings.per_page.user
  end

  def ban
		if @user.update_attributes user_params
			flash[:success] = t "user.messages.ban_success"
			redirect_back_or @user
		else
			flash[:warning] = t "user.messages.ban_fail"
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

  def restore
    user = User.with_deleted.find_by id: params[:id]
    if user.restore
      flash[:success] = t "user.messages.restore_success"
    else
      flash[:warning] = t "user.messages.restore_fail"
    end
    redirect_to managers_users_path
  end

  private

  attr_reader :user

  def find_user
    @user = User.find_by id: params[:id]
    return if user

    flash[:warning] = t "user.messages.not_found"
    redirect_to managers_root_path
  end

  def user_params
    params.require(:user).permit :role
  end

  def authorize_user
    authorize User, :admin?
  end
end
