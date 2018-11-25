class Managers::CategoryManagersController < Managers::BaseController
  before_action :authorize_category
  before_action :find_category, only: %i(new create)
  before_action :find_category_manager, only: :destroy

  def new
    @category_manager = category.category_managers.build
    @moderators = User.moderator.not_manager_category category
  end

  def create
    category_manager = category.category_managers.build category_manager_param
    if category_manager.save
      flash[:success] = t "category_manager.messages.create_successful"
      redirect_to new_managers_category_category_manager_path(category)
    else
      flash[:warning] = t "category_manager.messages.create_fail"
      render :new
    end
  end

  def destroy
    if @category_manager.destroy
      flash[:success] = t "category_manager.messages.delete_successful"
    else
      flash[:warning] = t "category_manager.messages.delete_fail"
    end
    redirect_to new_managers_category_category_manager_path(category_manager.category)
  end

  private

  attr_reader :category, :category_manager

  def find_category_manager
    @category_manager = CategoryManager.find_by id: params[:id]
    return if category_manager

    flash[:warning] = t "category_manager.messages.not_found"
    redirect_to new_managers_category_category_manager_path(category_manager.category)
  end

  def find_category
    @category = Category.find_by id: params[:category_id]
    return if category

    flash[:warning] = t "category.messages.not_found"
    redirect_to managers_categories_path
  end

  def category_manager_param
    params.require(:category_manager).permit :category_id, :user_id
  end

  def authorize_category
    authorize Category, :admin?
  end
end
