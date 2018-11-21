class AddEditorTopic < ActiveRecord::Migration[5.2]
  def change
    add_column :topics, :editor_id, :integer
  end
end
