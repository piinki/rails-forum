class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password
      t.integer :role, default: 0
      t.datetime :locked_at
      t.integer :banner

      t.timestamps
    end
  end
end
