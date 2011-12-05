class CreateMetropoliCities < ActiveRecord::Migration
  
  def self.up 
    create_table :cities do |t|
      t.integer :state_id
      t.string  :name
      t.float   :lat
      t.float   :long
    end
    add_index :cities, :name
    add_index :cities, :state_id
    add_index :cities, :lat
    add_index :cities, :long
  end
  
  def self.down
    drop_table :cities
  end
  
end