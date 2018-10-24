class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :user_name
      t.string :email
      t.string :password
      t.integer :role
      t.datetime :locked_at
      t.integer :banner

      t.timestamps
    end
  end
end
