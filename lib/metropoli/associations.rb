module Metropoli
  def self.included(base)
    base.send :extend, ClassMethods
  end
  
  module Associations
    
    def self.define_relation_methods(relation_name, relation_collector)
      define_method "#{relation_name}_name=" do |attr_name|
        write_attribute "#{relation_name}_name", attr_name
        write_attribute relation_collector, (City.autocomplete(attr_name) || [])
        if read_attribute(relation_collector).size == 1
          send "#{relation_name}=", read_attribute(relation_collector).first
        else
          send "#{relation_name}=", nil
        end
      end
    end
    
  end
  
  module ClassMethods
    
    def belongs_to_metropoli(args = {})
      relation_name = args[:with].nil? ? 'city' : args[:with].to_s
      relation_collector = "metropoli_#{relation_name.pluralize}".to_sym
      self.belongs_to :city, :class_name => "Metropoli::#{relation_name.classify}"
      Metropoli::Associations::define_relation_methods(relation_name, relation_collector)
      send :include, InstanceMethods
    end
    
    def has_many_metropoli(args = {})
      self.has_many :cities, :class_name => 'Metropoli::City'
      send :include, InstanceMethods
    end
    
  end
  
  module InstanceMethods
      
  end
  
end

ActiveRecord::Base.send :include, Metropoli