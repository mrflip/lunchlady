class AddShibbolethToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :shibboleth, :string, :null => false, :default => ""
  end

  def self.down
    remove_column :users, :shibboleth
  end
end
