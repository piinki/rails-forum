class AddColumCategory < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :description, :text
    add_column :categories, :permission_view, :integer
    add_column :categories, :permission_post, :integer
    add_column :categories, :published, :integer
  end
end
