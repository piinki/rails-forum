class Post < ApplicationRecord
  belongs_to :user
  belongs_to :topic

  has_many :votes, as: :ownerable, dependent: :destroy

  delegate :full_name, to: :user, prefix: true
end
