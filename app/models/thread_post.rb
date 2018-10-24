class ThreadPost < ApplicationRecord
  belongs_to :category
  belongs_to :user

  has_many :banner_functions, as: :groupable, dependent: :destroy
  has_many :posts, dependent: :destroy
end
