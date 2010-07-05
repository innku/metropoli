class Add<%= to_model.classify.pluralize %>To<%= model_name.classify.pluralize %> < ActiveRecord::Migration
  def self.up 
    create_table :<%= relation_name %> do |t|
      t.integer :<%= to_model %>_id
      t.integer :<%= model_name %>_id
    end
    
    add_index :<%= relation_name %>, :<%= to_model %>_id
    add_index :<%= relation_name %>, :<%= model_name %>_id
  end
  
  def self.down
    drop_table :<%= relation_name %>
  end
  
end