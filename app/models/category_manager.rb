class CategoryManager < ApplicationRecord
  belongs_to :category
  belongs_to :user

  has_paper_trail
end
