class AddCitiesToUsers < ActiveRecord::Migration
  def self.up 
    create_table :cities_users, :id =>false do |t|
      t.integer :city_id
      t.integer :user_id
    end
    
    add_index :cities_users, :city_id
    add_index :cities_users, :user_id
  end
  
  def self.down
    drop_table :cities_users
  end
  
end