class CreateMetropoliStates < ActiveRecord::Migration
  def self.up
    
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
    
  end
  
  def self.down
    drop_table :states
  end
  
end