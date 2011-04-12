ActiveRecord::Migration.verbose = false
ActiveRecord::Base.establish_connection :adapter => "sqlite3", :database => ":memory:"

ActiveRecord::Schema.define(:version => 1) do
  create_table :countries do |t|
    t.string :name
    t.string :alternate_names
    t.string :abbr
  end

  create_table :states do |t|
    t.integer :country_id
    t.string  :ascii_name
    t.string  :alternate_names
    t.string  :name
    t.string  :abbr
  end

  create_table :cities do |t|
    t.integer :state_id
    t.string  :ascii_name
    t.integer :population
    t.string  :alternate_names
    t.string  :name
  end
end
