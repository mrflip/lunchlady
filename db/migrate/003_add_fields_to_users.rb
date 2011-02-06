class AddFieldsToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :name, :string
    add_column :users, :username, :string
    add_column :users, :is_local, :boolean
  end

  def self.down
    remove_column :users, :is_local
    remove_column :users, :username
    remove_column :users, :name
  end
end
