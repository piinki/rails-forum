class Post < ApplicationRecord
  belongs_to :user
  belongs_to :topic
  belongs_to :editor, class_name: User.name, optional: true

  has_many :votes, as: :ownerable, dependent: :destroy

  validates :content, presence: true

  delegate :full_name, to: :user, prefix: true
end
