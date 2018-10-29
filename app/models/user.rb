class User < ApplicationRecord
  devise :database_authenticatable, :rememberable, :validatable, :registerable

  enum role: %i(normal moderator admin)

  has_many :thread_posts, dependent: :destroy, foreign_key: :creator_id
  has_many :banner_functions, dependent: :destroy
  has_many :category_managers, dependent: :destroy
  has_one :user_token, dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true

  def root_path
    routes = Rails.application.routes.url_helpers
    return routes.root_path if normal?
    routes.managers_root_path
  end

  def full_name
    "#{first_name} #{last_name}"
  end

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
