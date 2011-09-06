class AddIndexes < ActiveRecord::Migration
  def self.up

    remove_index  :rates,  [:rateable_id, :rateable_type]
    remove_index  :rates,  [:rater_id]
    add_index     :rates,  [:rateable_id, :rateable_type, :dimension, :stars]
    add_index     :rates,  [:rater_id, :rateable_id, :rateable_type, :dimension]
    add_index     :rates,  [:stars]

    add_index     :meals,  [:restaurant_id, :ordered_on]

    add_index     :orders, [:meal_id]

    add_column    :restaurants, :cached_slug, :string
    add_index     :restaurants, [:cached_slug]
    Restaurant.reset_column_information
    Restaurant.all.each{|r| succ = r.save ; puts "%-7s\t%35s\t%s" % [succ, r.cached_slug, r.name] }
  end

  def self.down
    add_index     :rates,  [:rateable_id, :rateable_type]
    # add_index     :rates,  [:rater_id]
    remove_index  :rates,  [:rateable_id, :rateable_type, :dimension, :stars]
    remove_index  :rates,  [:stars]
    # remove_index  :rates,  [:rater_id, :rateable_id, :rateable_type, :dimension]

    remove_index  :meals,  [:restaurant_id, :ordered_on]

    remove_index  :orders, [:meal_id]

    remove_column :restaurants, :cached_slug, :string
  end
end
