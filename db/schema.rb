# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 10) do

  create_table "meals", :force => true do |t|
    t.date      "ordered_on"
    t.integer   "restaurant_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.boolean   "done",          :default => false
  end

  add_index "meals", ["ordered_on"], :name => "index_meals_on_ordered_on", :unique => true

  create_table "orders", :force => true do |t|
    t.integer   "user_id"
    t.integer   "meal_id"
    t.text      "description"
    t.float     "price"
    t.float     "copay"
    t.integer   "guest_of"
    t.integer   "created_by"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  add_index "orders", ["user_id", "meal_id"], :name => "index_orders_on_user_id_and_meal_id", :unique => true

  create_table "rates", :force => true do |t|
    t.integer   "rater_id"
    t.integer   "rateable_id"
    t.string    "rateable_type"
    t.integer   "stars",         :null => false
    t.string    "dimension"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  add_index "rates", ["rateable_id", "rateable_type"], :name => "index_rates_on_rateable_id_and_rateable_type"
  add_index "rates", ["rater_id"], :name => "index_rates_on_rater_id"

  create_table "restaurants", :force => true do |t|
    t.string    "name"
    t.string    "phone"
    t.string    "url"
    t.string    "menu_url"
    t.text      "address"
    t.text      "note"
    t.boolean   "delivers"
    t.float     "delivery_fee"
    t.integer   "tip_percent"
    t.integer   "discount_percent"
    t.string    "inspection_url"
    t.string    "review_url"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.decimal   "rating_average",   :default => 0.0
  end

  add_index "restaurants", ["name"], :name => "index_restaurants_on_name", :unique => true

  create_table "slugs", :force => true do |t|
    t.string    "name"
    t.integer   "sluggable_id"
    t.integer   "sequence",                     :default => 1, :null => false
    t.string    "sluggable_type", :limit => 40
    t.string    "scope"
    t.timestamp "created_at"
  end

  add_index "slugs", ["name", "sluggable_type", "sequence", "scope"], :name => "index_slugs_on_n_s_s_and_s", :unique => true
  add_index "slugs", ["sluggable_id"], :name => "index_slugs_on_sluggable_id"

  create_table "users", :force => true do |t|
    t.string    "email",                               :default => "", :null => false
    t.string    "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string    "password_salt",                       :default => "", :null => false
    t.string    "reset_password_token"
    t.string    "remember_token"
    t.timestamp "remember_created_at"
    t.integer   "sign_in_count",                       :default => 0
    t.timestamp "current_sign_in_at"
    t.timestamp "last_sign_in_at"
    t.string    "current_sign_in_ip"
    t.string    "last_sign_in_ip"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "name"
    t.string    "username"
    t.boolean   "is_local"
    t.string    "shibboleth",                          :default => "", :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
