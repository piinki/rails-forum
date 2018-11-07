class Managers::CategoriesController < Managers::BaseController
  before_action :find_category, only: %i(show edit update destroy)

  def index
    @categories = Category.select :id, :title
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = "Create category successfully"
      redirect_to managers_categories_path
    else
      flash[:warning] = "Cannot create category"
      render :new
    end
  end

  def edit; end

  def update
    if @category.update_attributes category_params
      flash[:success] = "Update category successfully"
      redirect_to managers_categories_path
    else
      flash[:warning] = "Cannot update category"
      render :edit
    end
  end

  def destroy
    if @category.destroy
      flash[:success] = "Delete category successfully"
    else
      flash[:warning] = "Cannot Delete category"
    end
    redirect_to managers_categories_path
  end

  private

  attr_reader :category

  def find_category
    @category = Category.find_by id: params[:id]
    return if category

    flash[:warning] = "Cannot find category"
    redirect_to managers_categories_path
  end

  def category_params
    params.require(:category).permit :id, :title, :description, :permission_view, :status
  end
end
