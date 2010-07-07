module Metropoli
  module StatementHelper
    protected
    def self.like_statement(name)
      (where_clause << where_values(name)).flatten
    end
    
    def self.where_values(value)
      values = []
      self.autocomplete_fields.size.times{ values << value}
      values
    end
    
    def self.where_clause
      [self.autocomplete_fields.collect{|field| where_field(field) }.join(' OR ')]
    end
    
    def self.where_field(field)
      "cities.#{field} #{Metropoli::LIKE} ?"
    end
    
    def self.autocomplete_fields
      Metropoli.city_autocomplete_fields.split(',').map(&:strip)
    end
  end
end