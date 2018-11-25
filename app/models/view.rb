class View < ApplicationRecord
  belongs_to :topic, counter_cache: true
  belongs_to :user
end
