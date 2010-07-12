class AddStatesToUsers < ActiveRecord::Migration
  def self.up 
    create_table :states_users, :id =>false do |t|
      t.integer :state_id
      t.integer :user_id
    end
    
    add_index :states_users, :state_id
    add_index :states_users, :user_id
  end
  
  def self.down
    drop_table :states_users
  end
  
end