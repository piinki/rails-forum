class Post < ApplicationRecord
  belongs_to :user

  has_many :votes, as: :ownerable, dependent: :destroy
end
