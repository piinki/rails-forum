class Topic < ApplicationRecord
  belongs_to :category
  belongs_to :creator, class_name: User.name

  has_many :banner_functions, as: :groupable, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :votes, as: :ownerable, dependent: :destroy

  validates :title, presence: true

  accepts_nested_attributes_for :posts, allow_destroy: true

  delegate :first_name, to: :creator, prefix: true

  before_validation :additional_for_first_post

  def last_post
    posts.order(created_at: :desc).first
  end

  private

  def additional_for_first_post
    posts.first.user = creator
    posts.first.is_root = true
  end
end
