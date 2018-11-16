class Category < ApplicationRecord
  has_many :category_managers, dependent: :destroy
  has_many :banner_functions, as: :groupable, dependent: :destroy
  has_many :tags, dependent: :destroy
  has_many :topics, dependent: :destroy
  has_many :moderators, through: :category_managers, source: :user

  enum permission_view: %i(everyone user), _suffix: true
  enum status: %i(unpublish published)

  validates :title, presence: true, uniqueness: { case_sensitive: false }
  validates :description, presence: true
  validates :status, presence: true
  validates :permission_view, presence: true
end
