module PaperTrail
  class Version < ApplicationRecord
    include PaperTrail::VersionConcern

    def whoactor
      user = User.find_by id: whodunnit
      return user if user
      "Admin"
    end
  end
end
