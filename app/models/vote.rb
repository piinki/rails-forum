class Vote < ApplicationRecord
  belongs_to :ownerable, polymorphic: true
end
