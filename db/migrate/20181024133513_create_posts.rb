class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :topic_id
      t.text :content
      t.integer :user_id
      t.integer :up_vote
      t.integer :down_vote

      t.timestamps
    end
  end
end
