class AddCitiesTo<%= model_name.classify %> < ActiveRecord::Migration
  def self.up 
    change_table :<%= model_name %> do |t|
      t.integer :city_id
    end
    
    add_index :<%= model_name %>, :city_id
  end
  
  def self.down
    change_table :<%= model_name %> do |t|
      t.remove :city_id
    end
  end
  
end