class CreateBanHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :ban_histories do |t|
      t.integer :user_id
      t.integer :pic_id

      t.timestamps
    end
  end
end
