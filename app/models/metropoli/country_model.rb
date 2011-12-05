module Metropoli
  class CountryModel < ActiveRecord::Base
    extend StatementHelper
    extend ConfigurationHelper
    set_table_name  :countries
    
    has_many        :states, :class_name => Metropoli.state_class, :foreign_key => :country_id
    
    def self.autocomplete(string='')
      self.like(string)
    end
    
    def self.like(name)
      self.where(like_statement(name))
    end
    
    def self.is(name)
      self.where(find_statement(name))
    end
    
    def self.with_values(string)
      self.is(string)
    end
    
    def to_s
      "#{self.name}"
    end
    
    def as_json(opts={})
      opts||={}
      super(opts.merge({:only => [:id], :methods => [:to_s]}))
    end
  
  end
end