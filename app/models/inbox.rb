class Inbox < ApplicationRecord
  belongs_to :recipient, class_name: User.name
  belongs_to :creator, class_name: User.name
end
