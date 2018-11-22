class EditUser < ActiveRecord::Migration[5.2]
  def up
  	change_column :users, :banner, :date
  	rename_column :users, :banner, :expired_at
  end

  def down
  	rename_column :users, :expired_at, :banner
  	change_column :users, :banner, :integer
  end
end
