class AddDoneToMeal < ActiveRecord::Migration
  def self.up
    add_column :meals, :done, :boolean, :default => false
  end

  def self.down
    remove_column :meals, :done
  end
end
