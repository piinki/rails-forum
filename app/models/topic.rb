class Topic < ApplicationRecord
  belongs_to :category
  belongs_to :creator, class_name: User.name
  belongs_to :editor, class_name: User.name, optional: true

  has_many :banner_functions, as: :groupable, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :votes, as: :ownerable, dependent: :destroy

  validates :title, presence: true
  validate :limit_pin_topic, if: :pin_at_changed?

  accepts_nested_attributes_for :posts, allow_destroy: true

  scope :by_category, (lambda do |cates|
    where category: cates
  end)

  scope :pinted, -> { where.not pin_at: nil }
  scope :not_pin, -> { where(pin_at: nil).order(updated_at: :desc) }

  delegate :first_name, to: :creator, prefix: true

  before_validation :additional_for_first_post
  after_update :update_editor_for_root_post, if: :editor_id_changed?

  def last_post
    posts.order(created_at: :desc).first
  end

  def root_post
    posts.where(is_root: true).first
  end

  private

  def additional_for_first_post
    posts.first.user = creator
    posts.first.is_root = true
  end

  def update_editor_for_root_post
    root_post.update_attributes editor_id: editor_id
  end

  def limit_pin_topic
    return if category.topics.pinted.size < category.limit_topic_pin
    errors.add :limit_topic_pin, "Vuot qua gioi han"
  end
end
