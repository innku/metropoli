class AddCountriesToUsers < ActiveRecord::Migration
  def self.up 
    create_table :countries_users, :id =>false do |t|
      t.integer :country_id
      t.integer :user_id
    end
    
    add_index :countries_users, :country_id
    add_index :countries_users, :user_id
  end
  
  def self.down
    drop_table :countries_users
  end
  
end