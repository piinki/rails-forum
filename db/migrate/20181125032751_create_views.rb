class CreateViews < ActiveRecord::Migration[5.2]
  def change
    create_table :views do |t|
      t.string :ip_address
      t.integer :topic_id
      t.integer :user_id

      t.timestamps
    end
  end
end
