class Add<%= migration_name.classify %>To<%= app_table_name.classify.pluralize %> < ActiveRecord::Migration
  def self.up 
    change_table :<%= app_table_name %> do |t|
      <%- relation_aliases.each do |relation_alias| -%>
        t.integer :<%= relation_alias %>_id
      <%- end -%>
    end
    <%- relation_aliases.each do |relation_alias| -%>
      add_index :<%= app_table_name %>, :<%= relation_alias %>_id
    <%- end -%>
  end
  
  def self.down
    change_table :<%= app_table_name %> do |t|
      <%- relation_aliases.each do |relation_alias| -%>
        t.remove :<%= relation_alias -%>_id
      <%- end -%>
    end
  end
  
end