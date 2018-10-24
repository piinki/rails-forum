class CreateThreadPosts < ActiveRecord::Migration[5.2]
  def change
    create_table :thread_posts do |t|
      t.string :title
      t.integer :creator_id
      t.integer :catrgory_id
      t.datetime :locked_at

      t.timestamps
    end
  end
end
