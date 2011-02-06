class CreateMeals < ActiveRecord::Migration
  def self.up
    create_table :meals do |t|
      t.date    :ordered_on
      t.integer :restaurant_id
      t.timestamps
    end
    add_index :meals, [:ordered_on], :unique => true
  end

  def self.down
    drop_table :meals
  end
end
