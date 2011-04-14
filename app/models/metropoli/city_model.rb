module Metropoli
  class CityModel < ActiveRecord::Base    
    extend StatementHelper

    set_table_name  :cities
    belongs_to      :state,   :class_name => Metropoli.state_class
    delegate        :country, :to => :state

    def to_s
      "#{self.name}, #{self.state.name}, #{self.country.iso}"
    end
    alias :text :to_s
    
    def as_json opts = {}
      super({:root => :city, :only => [:id], :methods => [:to_s]}.merge(opts || {})) 
    end

    class << self
      def autocomplete(string)
        city, state, country = string.to_s.split(',').map(&:strip)
        like(city).includes(:state => :country).merge( country_class.like(country).merge(state_class.like(state)) ).order('population desc')
      end

      def by_string(string)
        city, state, country = string.to_s.split(',').map(&:strip)

        results = is(city).includes(:state => :country)
        results = results.merge state_class.is(state)     if state
        results = results.merge country_class.is(country) if country
        results
      end
    end
  end
end
