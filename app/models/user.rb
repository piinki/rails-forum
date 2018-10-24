class User < ApplicationRecord
  has_many :thread_posts, dependent: :destroy, foreign_key: :creator_id
  has_many :banner_functions, dependent: :destroy
  has_many :category_managers, dependent: :destroy
  has_one :user_token, dependent: :destroy
end
