class CreateInbox < ActiveRecord::Migration[5.2]
  def change
    create_table :inboxes do |t|
      t.text :content
      t.integer :user_id
      t.integer :creator_id

      t.timestamps
    end
  end
end
