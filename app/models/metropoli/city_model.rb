module Metropoli
  class CityModel < ActiveRecord::Base    
    set_table_name  :cities
    belongs_to      :state,   :class_name => Metropoli.state_class
    delegate        :country, :to => :state
    
    extend StatementHelper
    extend ConfigurationHelper
    

    def to_s
      "#{self.name}, #{self.state.name}, #{self.country.abbr}"
    end
    
    def metropoli_json
      self.to_json(:root => :city, 
                   :only => [:id],
                   :methods => [:to_s])
    end

    def self.autocomplete(string)
      city, state, country = string.to_s.split(',').map(&:strip)

      results = like(city)
      results = results.includes(:state => :country)

      if !country.blank?
        results = results.merge country_class.like(country).merge(state_class.like(state)) 
      elsif !state.blank?
        results = results.merge state_class.like(state)
      end

      results.order('population desc')
    end
  end
end
