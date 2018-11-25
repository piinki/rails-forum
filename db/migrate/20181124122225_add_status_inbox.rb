class AddStatusInbox < ActiveRecord::Migration[5.2]
  def change
    add_column :inboxes, :status, :integer, default: 0
    add_column :inboxes, :title, :string, null: false
    add_column :posts, :view, :integer, default: 0
    rename_column :inboxes, :user_id, :recipient_id
  end
end
