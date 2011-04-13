module Metropoli
  class CountryModel < ActiveRecord::Base
    set_table_name  :countries
    has_many        :states, :class_name => Metropoli.state_class, :foreign_key => :country_id, :dependent => :destroy

    extend StatementHelper
    extend ConfigurationHelper
    
    def to_s
      "#{self.name}"
    end
    
    def metropoli_json
      self.to_json(:root => :country, :only => [:id], :methods => [:to_s])
    end
  
    class << self
      alias :autocomplete :like
      alias :by_string :is
    end
  end
end
