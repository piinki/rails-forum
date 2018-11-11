class AddPinatToTopic < ActiveRecord::Migration[5.2]
  def change
    add_column :topics, :pin_at, :datetime
  end
end
