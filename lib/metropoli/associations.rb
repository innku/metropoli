module Metropoli
  def self.included(base)
    base.send :extend, ClassMethods
  end
  
  module ClassMethods
    
    def belongs_to_metropoli(args = {})
      relation_class_name = args[:with].nil? ? 'City' : args[:with].to_s.classify
      relation_name = args[:as].nil? ? relation_class_name.downcase : args[:as].to_s
      relation_class = eval(relation_class_name)
      relation_collector = "metropoli_#{relation_name.pluralize}".to_sym

      self.belongs_to relation_name.to_sym, :class_name => "Metropoli::#{relation_class_name}"

      define_method "#{relation_name}_name=" do |attr_name|
        write_attribute "#{relation_name}_name", attr_name
        write_attribute relation_collector, (relation_class.autocomplete(attr_name) || [])
        if read_attribute(relation_collector).size == 1
          send "#{relation_name}=", read_attribute(relation_collector).first
        else
          send "#{relation_name}=", nil
        end
      end

      define_method "#{relation_name}_name" do
        metropoli_attribute = send(relation_name)
        return read_attribute("#{relation_name}_name") if read_attribute("#{relation_name}_name")
        return metropoli_attribute.to_s if metropoli_attribute
      end
      
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