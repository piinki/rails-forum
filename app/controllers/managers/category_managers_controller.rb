class Managers::CategoryManagersController < Managers::BaseController
  before_action :find_category, only: %i(new create)
  before_action :find_category_manager, only: :destroy

  def new
    @category_manager = category.category_managers.build
    @moderators = User.moderator.not_manager_category category
  end

  def create
    category_manager = category.category_managers.build category_manager_param
    if category_manager.save
      flash[:success] = "Add moderator successfully"
      redirect_to new_managers_category_category_manager_path(category)
    else
      flash[:warning] = "Cannot add moderator"
      render :new
    end
  end

  def destroy
    if @category_manager.destroy
      flash[:success] = "Delete category manager successfully"
    else
      flash[:warning] = "Cannot Delete manager category"
    end
    redirect_to new_managers_category_category_manager_path(category_manager.category)
  end

  private

  attr_reader :category, :category_manager

  def find_category_manager
    @category_manager = CategoryManager.find_by id: params[:id]
    return if category_manager

    flash[:warning] = "Cannot find category manager"
    redirect_to new_managers_category_category_manager_path(category_manager.category)
  end

  def find_category
    @category = Category.find_by id: params[:category_id]
    return if category

    flash[:warning] = "Cannot find category"
    redirect_to managers_categories_path
  end

  def category_manager_param
    params.require(:category_manager).permit :category_id, :user_id
  end
end
