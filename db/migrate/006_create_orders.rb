class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.integer :user_id
      t.integer :meal_id
      t.text    :description
      t.float   :price
      t.float   :copay
      t.integer :guest_of
      t.integer :created_by
      t.timestamps
    end
    add_index :orders, [:user_id, :meal_id], :unique => true
  end

  def self.down
    drop_table :orders
  end
end
