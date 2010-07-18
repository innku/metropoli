module Metropoli
  class CityModel < ActiveRecord::Base    
    set_table_name  :cities
    belongs_to      :state,   :class_name => Metropoli.state_class
    delegate        :country, :to => :state
    
    extend StatementHelper
    extend ConfigurationHelper
    
    def self.autocomplete(string='')
      city, state, country = string.split(',').map(&:strip)
      results = self.like(city)
      results = results.includes(:state => :country)
      if !country.blank?
        results &= country_class.like(country) & state_class.like(state)
      elsif !state.blank?
        results &= state_class.like(state)
      end
      results
    end
  
    def self.like(name)
      self.where(like_statement(name))
    end
    
    def self.is(name)
      self.where(find_statement(name))
    end
    
    def self.with_values(string)
      city, state, country = string.split(',').map(&:strip)
      results = []
      unless city.blank?
        results = self.is(city)
        results = results.includes(:state => :country)
        if !country.blank?
          results &= country_class.is(country) & state_class.is(state)
        elsif !state.blank?
          results &= state_class.is(state)
        end
      end
      results
    end
    
    def to_s
      "#{self.name}, #{self.state.name}, #{self.country.abbr}"
    end
  
  end
end