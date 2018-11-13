class Managers::UsersController < Managers::BaseController
  before_action :find_user, only: %i(show edit update destroy)

  def index
    @users = User.all.page(params[:page]).per Settings.per_page.user
  end

  def show; end

  def destroy
    if user.destroy
      flash[:success] = "Delete success"
    else
      flash[:warning] = "Cannot delete user"
    end
    redirect_to managers_root_path
  end

  private

  attr_reader :user

  def find_user
    @user = User.find_by id: params[:id]
    return if user

    flash[:warning] = "Cannot found user"
    redirect_to managers_root_path
  end
end
