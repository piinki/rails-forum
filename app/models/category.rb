class Category < ApplicationRecord
  has_many :category_managers, dependent: :destroy
  has_many :banner_functions, as: :groupable, dependent: :destroy
  has_many :tags, dependent: :destroy
  has_many :topics, dependent: :destroy
end
