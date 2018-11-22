class CategoriesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i(show)
  before_action :find_category, only: :show

  def show
    authorize category
    @topics_pined = category.topics.pinted
    @topics = category.topics.not_pin.page(params[:page]).per Settings.per_page.topic
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
