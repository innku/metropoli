# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100712220212) do

  create_table "cities", :force => true do |t|
    t.integer "state_id"
    t.string  "name"
  end

  add_index "cities", ["name"], :name => "index_cities_on_name"
  add_index "cities", ["state_id"], :name => "index_cities_on_state_id"

  create_table "cities_users", :id => false, :force => true do |t|
    t.integer "city_id"
    t.integer "user_id"
  end

  add_index "cities_users", ["city_id"], :name => "index_cities_users_on_city_id"
  add_index "cities_users", ["user_id"], :name => "index_cities_users_on_user_id"

  create_table "countries", :force => true do |t|
    t.string "name"
    t.string "abbr"
  end

  add_index "countries", ["abbr"], :name => "index_countries_on_abbr"
  add_index "countries", ["name"], :name => "index_countries_on_name"

  create_table "countries_users", :id => false, :force => true do |t|
    t.integer "country_id"
    t.integer "user_id"
  end

  add_index "countries_users", ["country_id"], :name => "index_countries_users_on_country_id"
  add_index "countries_users", ["user_id"], :name => "index_countries_users_on_user_id"

  create_table "states", :force => true do |t|
    t.integer "country_id"
    t.string  "name"
    t.string  "abbr"
  end

  add_index "states", ["abbr"], :name => "index_states_on_abbr"
  add_index "states", ["country_id"], :name => "index_states_on_country_id"
  add_index "states", ["name"], :name => "index_states_on_name"

  create_table "states_users", :id => false, :force => true do |t|
    t.integer "state_id"
    t.integer "user_id"
  end

  add_index "states_users", ["state_id"], :name => "index_states_users_on_state_id"
  add_index "states_users", ["user_id"], :name => "index_states_users_on_user_id"

  create_table "users", :force => true do |t|
    t.string  "name"
    t.integer "city_id"
  end

  add_index "users", ["city_id"], :name => "index_users_on_city_id"

end
