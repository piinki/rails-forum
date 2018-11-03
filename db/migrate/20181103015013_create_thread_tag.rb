class CreateThreadTag < ActiveRecord::Migration[5.2]
  def change
    create_table :topic_tags do |t|
      t.integer :tag_id
      t.integer :topic

      t.timestamps
    end
  end
end
