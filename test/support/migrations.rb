ActiveRecord::Migration.verbose = false
ActiveRecord::Base.establish_connection :adapter => "sqlite3", :database => ":memory:"

# Run migrations from templates
require("#{File.dirname __FILE__}/../../lib/generators/metropoli/install/templates/migrate/create_metropoli_cities")
require("#{File.dirname __FILE__}/../../lib/generators/metropoli/install/templates/migrate/create_metropoli_states")
require("#{File.dirname __FILE__}/../../lib/generators/metropoli/install/templates/migrate/create_metropoli_countries")

CreateMetropoliCities.up
CreateMetropoliStates.up
CreateMetropoliCountries.up

ActiveRecord::Schema.define(:version => 4) do
  create_table :users do |t|
    t.string  :name
    t.integer :country_id
    t.integer :state_id
    t.integer :city_id
  end

  create_table :cities_users, :id =>false do |t|
    t.integer :city_id
    t.integer :user_id
  end

  create_table :states_users, :id =>false do |t|
    t.integer :state_id
    t.integer :user_id
  end

  create_table :countries_users, :id =>false do |t|
    t.integer :country_id
    t.integer :user_id
  end
end
