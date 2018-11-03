class CreateTopics < ActiveRecord::Migration[5.2]
  def change
    create_table :topics do |t|
      t.string :title
      t.integer :creator_id
      t.integer :category_id
      t.datetime :locked_at

      t.timestamps
    end
  end
end
