class AddUserName < ActiveRecord::Migration
  def change
    add_column :users, :user_name, :string
    change_column :users, :user_name, :string, null: false
    add_index :users, :user_name, unique: true
  end
end
