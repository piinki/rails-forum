class Category < ApplicationRecord
  has_many :category_managers, dependent: :destroy
  has_many :banner_functions, as: :groupable, dependent: :destroy
end
