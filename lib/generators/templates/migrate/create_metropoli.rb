class CreateMetropoli < ActiveRecord::Migration
  def self.up
    
    create_table :countries do |t|
      t.string :name
      t.string :abbr
    end
    
    add_index :countries, :name
    add_index :countries, :abbr
    
    create_table :states do |t|
      t.integer :country_id
      t.string  :name
      t.string  :abbr
      t.string  :abbr2
      t.string  :abbr3
    end
    
    add_index :states, :country_id
    add_index :states, :name
    add_index :states, :abbr
    add_index :states, :abbr2
    add_index :states, :abbr3
    
    create_table :cities do |t|
      t.integer :state_id
      t.string  :name
      t.string  :alt_name
    end
    
    add_index :cities, :name
    add_index :cities, :alt_name
    add_index :cities, :state_id
  end
  
  def self.down
    drop_table :countries
    drop_table :states
    drop_table :cities
  end
  
end