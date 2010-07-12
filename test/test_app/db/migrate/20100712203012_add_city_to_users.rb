class AddCityToUsers < ActiveRecord::Migration
  def self.up 
    change_table :users do |t|
        t.integer :city_id
    end
      add_index :users, :city_id
  end
  
  def self.down
    change_table :users do |t|
        t.remove :city_id
    end
  end
  
end