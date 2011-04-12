module Metropoli
  class StateModel < ActiveRecord::Base
    set_table_name  :states
    
    belongs_to      :country, :class_name => Metropoli.country_class
    has_many        :cities,  :class_name => Metropoli.city_class, :foreign_key => :state_id, :dependent => :destroy

    extend StatementHelper
    extend ConfigurationHelper
    
    def to_s
      "#{self.name}, #{self.country.name}"
    end
    
    def metropoli_json
      self.to_json(:root => :state, 
                   :only => [:id],
                   :methods => [:to_s])
    end

    def self.autocomplete(string)
      state, country = string.to_s.split(',').map(&:strip)
      country.blank? ? like(state) : like(state).includes(:country).merge(country_class.like(country))
    end
  end
end
