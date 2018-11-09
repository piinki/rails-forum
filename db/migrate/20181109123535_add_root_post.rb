class AddRootPost < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :is_root, :boolean
  end
end
