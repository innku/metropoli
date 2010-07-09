module Metropoli
  class CityModel < ActiveRecord::Base    
    set_table_name  :cities
    belongs_to      :state,   :class_name => Metropoli.state_class
    delegate        :country, :to => :state
    
    extend StatementHelper
    extend ConfigurationHelper
    
    def self.autocomplete(string)
      unless string.blank?
        city, state, country = string.split(',').map(&:strip)
        results = self.like(city) unless city.nil?
        results = results.includes(:state => :country)
        if !country.blank?
          results &= country_class.like(country) & state_class.like(state)
        elsif !state.blank?
          results &= state_class.like(state)
        end
      end
      results
    end
  
    def self.like(name)
      self.where(like_statement(name))
    end
    
    def to_s
      "#{self.name}, #{self.state.abbr}, #{self.country.abbr}"
    end
  
  end
end