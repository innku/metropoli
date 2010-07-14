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
    
    def autocomplete_fields
      Metropoli.send("#{class_name}_autocomplete_fields").split(',').map(&:strip)
    end
    
    def class_name
      model_name.to_s.gsub(/Metropoli::|Model/, '').to_s.downcase
    end
    
  end
end