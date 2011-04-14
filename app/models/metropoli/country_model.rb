module Metropoli
  class CountryModel < ActiveRecord::Base
    extend StatementHelper

    set_table_name  :countries
    has_many        :states, :class_name => Metropoli.state_class, :foreign_key => :country_id, :dependent => :destroy
    
    def to_s
      "#{self.name}"
    end
    alias :text :to_s
    
    def as_json opts = {}
      super({:root => :country, :only => [:id], :methods => [:to_s]}.merge(opts || {})) 
    end
  
    class << self
      alias :autocomplete :like
      alias :by_string :is
    end
  end
end
