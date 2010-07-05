class Add<%= to_model.classify %>To<%= model_name.classify.pluralize %> < ActiveRecord::Migration
  def self.up 
    change_table :<%= model_name %> do |t|
      t.integer :<%= to_model %>_id
    end
    
    add_index :<%= model_name %>, :<%= to_model %>_id
  end
  
  def self.down
    change_table :<%= model_name %> do |t|
      t.remove :<%= to_model %>_id
    end
  end
  
end