class User < ApplicationRecord
  devise :database_authenticatable, :rememberable, :validatable, :registerable

  enum role: %i(normal moderator admin)

  has_many :topics, dependent: :destroy, foreign_key: :creator_id
  has_many :banner_functions, dependent: :destroy
  has_many :category_managers, dependent: :destroy
  has_one :user_token, dependent: :destroy

  has_one_attached :avatar

  attr_accessor :current_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validate :validate_current_password, if: :validate_password?, on: :update
  validate :validate_same_password, if: :validate_password?, on: :update

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

  private

  def validate_password?
    !password.blank?
  end

  def validate_current_password
    user = User.find_by id: id
    return if user.valid_password?(current_password)
    errors.add(:current_password, "is incorrect.")
  end

  def validate_same_password
    user = User.find_by id: id
    return unless user.valid_password?(password)
    errors.add(:password, "not same old password.")
  end
end
