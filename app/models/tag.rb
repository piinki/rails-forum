class Tag < ApplicationRecord
  belongs_to :category

  has_many :topic_tags, dependent: :destroy
end
