class Managers::CategoriesController < Managers::BaseController
  before_action :authorize_category, except: :index
  before_action :find_category, only: %i(show edit update destroy)

  def index
    @categories = Category.all.includes(:category_managers)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "category.messages.create_successful"
      redirect_to managers_categories_path
    else
      flash[:warning] = t "category.messages.create_fail"
      render :new
    end
  end

  def edit; end

  def update
    if @category.update_attributes category_params
      flash[:success] = t "category.messages.update_successful"
      redirect_to managers_categories_path
    else
      flash[:warning] = t "category.messages.update_fail"
      render :edit
    end
  end

  def destroy
    if @category.destroy
      flash[:success] = t "category.messages.delete_success"
    else
      flash[:warning] = t "category.messages.delete_fail"
    end
    redirect_to managers_categories_path
  end

  private

  attr_reader :category

  def find_category
    @category = Category.find_by id: params[:id]
    return if category

    flash[:warning] = t "category.messages.not_found"
    redirect_to managers_categories_path
  end

  def category_params
    params.require(:category).permit :id, :title, :description, :permission_view, :status, :limit_topic_pin
  end

  def authorize_category
    authorize Category, :admin?
  end
end
