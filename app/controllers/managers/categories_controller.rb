module Managers
  class CategoriesController < Managers::BaseController
    def index
      @categories = Category.select :id, :title
      @new_category = Category.new
    end

    def create
      tags = params[:tags].split(",")

      @category = Category.new title: params[:category][:title]
      tags.each do |t|
        category.tags.build title: t
      end

      if category.save
        flash[:success] = "Create success"
      else
        flash[:warning] = "Cannot create category"
      end

      redirect_to managers_categories_path
    end

    private

    attr_reader :category
  end
end
