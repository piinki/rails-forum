class CategoriesController < ApplicationController
  before_action :find_category, only: :show
  
  def show
    @topics = category.topics
  end

  private

  attr_reader :category

  def find_category
    @category = Category.find_by id: params[:id]
    return if category

    flash[:warning] = "Cannot found category"
    redirect_to root_path
  end
end
