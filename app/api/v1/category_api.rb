class V1::CategoryAPI < Grape::API
  resource :categories do
    before do
      authenticate!
    end

    desc "Get all category"
    get do
      categories = Category.all
      {
        categories: ActiveModel::Serializer::CollectionSerializer.new(categories, serializer: V1::CategorySerializer)
      }
    end

    desc "Create category"
    params do
      requires :title, type: String
      optional :tags, type: String
    end
    post do
      authorize_admin!
      tags = params.tags.split(",");

      category = Category.new title: params.title
      tags.each do |t|
        category.tags.build title: t
      end

      category.save

      {
        category: V1::CategorySerializer.new(category)
      }
    end
  end
end
