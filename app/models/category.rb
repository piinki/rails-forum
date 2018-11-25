class Category < ApplicationRecord
  has_paper_trail

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
  validates :limit_topic_pin, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5}
end
