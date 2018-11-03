class Topic < ApplicationRecord
  belongs_to :category
  belongs_to :user

  has_many :banner_functions, as: :groupable, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :votes, as: :ownerable, dependent: :destroy
  has_many :tags, dependent: :destroy
end
