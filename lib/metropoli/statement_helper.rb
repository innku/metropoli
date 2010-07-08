#TODO Refactoring to set this values only once per application start

module Metropoli
  module StatementHelper
    protected 
    def like_statement(name)
      (where_clause << where_values(name)).flatten
    end
    
    def where_values(value)
      values = []
      self.autocomplete_fields.size.times{ values << "%#{value}%"}
      values
    end
    
    def where_clause
      [self.autocomplete_fields.collect{|field| where_field(field) }.join(' OR ')]
    end
    
    def where_field(field)
      "#{self.table_name}.#{field} #{Metropoli::LIKE} ?"
    end
    
    def city_class
      eval(Metropoli.city_class)
    end
    
    def state_class
      eval(Metropoli.state_class)
    end
    
    def country_class
      eval(Metropoli.country_class)
    end
    
    def autocomplete_fields
      Metropoli.send("#{self.class_name.downcase}_autocomplete_fields").split(',').map(&:strip)
    end
  end
end