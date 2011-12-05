module Metropoli
  def self.included(base)
    base.send :extend, ClassMethods
  end
  
  module Messages
    def self.error(class_name, kind)
      I18n.t( kind, :scope => [:metropoli, self.class.to_s.downcase])
    end
  end 
  
  module ClassMethods
    
    def metropoli_for(metropoli_model, opts = {})
      metropoli_relation = metropoli_model.to_s
      relation_class_name = ConfigurationHelper.relation_class_for(metropoli_relation)
      relation_name = (opts[:as] ? opts[:as].to_s : nil) || ConfigurationHelper.relation_name_for(metropoli_relation)
      relation_class = eval(relation_class_name)
      relation_collector = "metropoli_#{relation_name.pluralize}".to_sym

      self.belongs_to relation_name.to_sym, :class_name => relation_class_name

      define_method "#{relation_name}_name=" do |attr_value|
        write_attribute "#{relation_name}_name", attr_value
        write_attribute relation_collector, (relation_class.with_values(attr_value) || [])
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
      
      #Validation Methods
      if opts[:required] || opts[:required_if]
        #TODO optimize this
        if opts[:required_if]
          validates_presence_of   relation_name, :if => opts[:required_if]
        else
          validates_presence_of   relation_name
        end
        validate do |record|
          collection = record.read_attribute(relation_collector)
          relation = record.read_attribute(relation_name)
          needs_validation = opts[:required_if].nil? ? true : record.send(opts[:required_if])
          if collection && needs_validation
            if (collection.size > 1 rescue nil)
              record.errors.add(relation_name, Metropoli::Messages.error(metropoli_relation, :found_too_many))
            end
            if (collection.size == 0)
              record.errors.add(relation_name, Metropoli::Messages.error(metropoli_relation, :couldnt_find))
            end
          end
        end
      end      
    end
  end
end

ActiveRecord::Base.send :include, Metropoli