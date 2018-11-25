class AddCounterCacheToTopic < ActiveRecord::Migration[5.2]
  def change
    add_column :topics, :views_count, :integer, default: 0
    add_column :topics, :posts_count, :integer, default: 0
  end
end
