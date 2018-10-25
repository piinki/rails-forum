class CreateVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :votes do |t|
      t.integer :user_id
      t.integer :ownerable_id
      t.string :ownerable_type
      t.integer :vote_type

      t.timestamps
    end
  end
end
