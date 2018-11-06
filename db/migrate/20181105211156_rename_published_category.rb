class RenamePublishedCategory < ActiveRecord::Migration[5.2]
  def change
    rename_column :categories, :published, :status
  end
end
