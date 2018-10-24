class CreateBannerFunctions < ActiveRecord::Migration[5.2]
  def change
    create_table :banner_functions do |t|
      t.integer :user_id
      t.integer :groupable_id
      t.string :groupable_type

      t.timestamps
    end
  end
end
