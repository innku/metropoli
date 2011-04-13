module Metropoli
  module Messages
    def self.error(class_name, kind)
      I18n.t( kind, :scope => [:metropoli, self.class.to_s.downcase])
    end
  end 

  module Associations
    def self.included(base)
      base.send :extend, ClassMethods
    end

    module ClassMethods
      def metropoli_for(metropoli_model, args = {})
        metropoli_relation  = metropoli_model.to_s
        relation_class_name = ConfigurationHelper.relation_class_for(metropoli_relation)
        relation_name       = args[:as] ? args[:as].to_s : ConfigurationHelper.relation_name_for(metropoli_relation)
        relation_class      = relation_class_name.constantize
        relation_collector  = "metropoli_#{relation_name.pluralize}".to_sym

        belongs_to relation_name.to_sym, :class_name => relation_class_name

        define_method "#{relation_name}_name=" do |attr_value|
          collection = relation_class.by_string(attr_value)
          write_attribute "#{relation_name}_name", attr_value
          write_attribute relation_collector, collection
          send "#{relation_name}=", (collection.count == 1 ? collection.first : nil)
        end

        define_method "#{relation_name}_name" do
          read_attribute("#{relation_name}_name") || send(relation_name).try(:to_s)
        end

        #Validation Methods
        if args[:required_if] || args[:required] 
          validates_presence_of relation_name, :if => args[:required_if] || lambda{true}
        end      

        validate do |record| # not dependent on required or required_if, is it right?
          collection = record.read_attribute(relation_collector)
          unless collection.nil?
            record.errors.add(relation_name, Metropoli::Messages.error(metropoli_relation, :found_too_many)) if (collection.count > 1)
            record.errors.add(relation_name, Metropoli::Messages.error(metropoli_relation, :couldnt_find))   if (collection.count == 0)
          end
        end
      end

      def metropoli_for_many(metropoli_model, args = {})
        metropoli_relation  = metropoli_model.to_s.singularize
        relation_class_name = ConfigurationHelper.relation_class_for(metropoli_model)
        relation_name       = (args[:as] ? args[:as].to_s : nil) || ConfigurationHelper.relation_name_for(metropoli_model.to_s, 'has_many')
        relation_class      = eval(relation_class_name)
        joint_table         = [self.table_name, relation_class.table_name].sort.join('_')

        self.has_and_belongs_to_many relation_name.to_sym, :class_name => relation_class_name, 
          :join_table => joint_table,
          :association_foreign_key => "#{relation_name.singularize}_id"

        define_method "add_#{relation_name.singularize}" do |attr_value|
          results = relation_class.by_string(attr_value)
          collection = send("#{relation_name}")
          if (results.count == 1)
            element = results.first
            unless (args[:unique] and collection.include?(element))
              collection << results.first
              return element
            end
          end
          nil
        end

        define_method "remove_#{relation_name.singularize}" do |attr_value|
          results = relation_class.by_string(attr_value)
          if results.count == 1
            send("#{relation_name}").delete(results.first)
            results.first
          else
            nil
          end
        end

        if args[:required]
          validate do |record|
            min = args[:min] || 1
            collection = record.send(relation_name)

            if collection.size < min
              record.errors.add(relation_name, Metropoli::Messages.error(metropoli_relation, :not_enough))
            end

            if (args[:max] and (collection.size > args[:max].to_i))
              record.errors.add(relation_name, Metropoli::Messages.error(metropoli_relation, :too_many))
            end

          end
        end      
      end

    end
  end
  
end

ActiveRecord::Base.send :include, Metropoli::Associations
