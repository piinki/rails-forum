class V1::CategorySerializer < ActiveModel::Serializer
  attributes :id, :title, :tags

  def tags
    object.tags.size
  end
end
