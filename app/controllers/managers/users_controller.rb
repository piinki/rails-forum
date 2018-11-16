class Managers::UsersController < Managers::BaseController
  before_action :find_user, only: %i(show edit update destroy)

  def index
    @users = User.page(params[:page]).per Settings.per_page.user
  end

  def show; end

  def edit
    @categories = Category.all
  end

  def update
    authorize user
    if user.update_attributes user_params
      flash[:success] = "Change Permision success"
      redirect_to managers_users_path
    else
      flash[:warning] = "Cannot Change Permision user"
      render :edit
    end
  end

  def destroy
    authorize user
    if user.destroy
      flash[:success] = "Delete success"
    else
      flash[:warning] = "Cannot delete user"
    end
    redirect_to managers_users_path
  end

  private

  attr_reader :user

  def find_user
    @user = User.find_by id: params[:id]
    return if user

    flash[:warning] = "Cannot found user"
    redirect_to managers_root_path
  end

  def user_params
    params.require(:user).permit :role
  end
end
