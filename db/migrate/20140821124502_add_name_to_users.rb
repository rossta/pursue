class AddNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string, length: 128
    add_column :users, :last_name, :string, length: 128
  end
end
