class CreateRestaurants < ActiveRecord::Migration
  def self.up
    create_table :restaurants do |t|
      t.string :name
      t.string :phone
      t.string :url
      t.string :menu_url
      t.text :address
      t.text :note
      t.boolean :delivers
      t.float :delivery_fee
      t.integer :tip_percent
      t.integer :discount_percent
      t.string :inspection_url
      t.string :review_url
      t.timestamps
    end
    add_index :restaurants, [:name], :unique => true
  end

  def self.down
    drop_table :restaurants
  end
end
