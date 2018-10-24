class CreateCategoryManagers < ActiveRecord::Migration[5.2]
  def change
    create_table :category_managers do |t|
      t.integer :category_id
      t.integer :user_id

      t.timestamps
    end
  end
end
