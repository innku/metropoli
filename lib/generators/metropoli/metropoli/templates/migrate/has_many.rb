class Add<%= metropoli_model.classify.pluralize %>To<%= app_table_name.classify.pluralize %> < ActiveRecord::Migration
  def self.up 
    create_table :<%= relation_name %> do |t|
      t.integer :<%= metropoli_model.singularize %>_id
      t.integer :<%= app_table_name.singularize %>_id
    end
    
    add_index :<%= relation_name %>, :<%= metropoli_model.singularize %>_id
    add_index :<%= relation_name %>, :<%= app_table_name.singularize %>_id
  end
  
  def self.down
    drop_table :<%= relation_name %>
  end
  
end