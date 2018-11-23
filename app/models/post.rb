class Post < ApplicationRecord
  acts_as_paranoid
  has_paper_trail

  belongs_to :user
  belongs_to :topic
  belongs_to :editor, class_name: User.name, optional: true

  has_many :votes, as: :ownerable, dependent: :destroy


  validates :content, presence: true

  delegate :full_name, to: :user, prefix: true

  after_restore :create_version_restore

  private

  def create_version_restore
    versions.create! event: "restore", whodunnit: PaperTrail.request.whodunnit
  end
end
