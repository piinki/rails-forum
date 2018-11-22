class AddLimitPinTopic < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :limit_topic_pin, :integer
  end
end
