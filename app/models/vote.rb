class Vote < ApplicationRecord
  belongs_to :ownerable, polymorphic: true
  belongs_to :user

  enum vote_type: %i(up down), _suffix: true
end
