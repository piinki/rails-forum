class Post < ApplicationRecord
  belongs_to :user
  belongs_to :thread_post

  has_many :votes, as: :ownerable, dependent: :destroy
end
