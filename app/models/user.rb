class User < ApplicationRecord
  devise :database_authenticatable, :rememberable, :validatable

  enum role: %i(normal moderator admin)

  has_many :thread_posts, dependent: :destroy, foreign_key: :creator_id
  has_many :banner_functions, dependent: :destroy
  has_many :category_managers, dependent: :destroy
  has_one :user_token, dependent: :destroy

  class << self

    # For API
    def authenticate!(email, password)
      user = User.find_by email: email
      unless user.try :valid_password?, password
        raise APIError::WrongEmailPassword
      end
      user
    end
  end
end
