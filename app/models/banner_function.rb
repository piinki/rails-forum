class BannerFunction < ApplicationRecord
  belongs_to :user
  belongs_to :groupable, polymorphic: true
end
