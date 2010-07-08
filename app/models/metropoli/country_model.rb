module Metropoli
  class CountryModel < ActiveRecord::Base
    set_table_name  :countries
    has_many        :states, :class_name => Metropoli.state_class, :foreign_key => :country_id
    extend StatementHelper
    
    def self.autocomplete(string)
      self.like(string)
    end
    
    def self.like(name)
      self.where(like_statement(name))
    end
    
    def to_s
      "#{self.name}"
    end
  
  end
end