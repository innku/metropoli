module Metropoli
  class City < ActiveRecord::Base    
    belongs_to  :state, :class_name => Metropoli.state_class
    delegate    :country, :to => :state
    
    extend StatementHelper
    
    def self.autocomplete(string)
      city, state, country = string.split(',').map(&:strip)
      results = city_class.like(city) unless city.nil?
      if !country.blank?
        results = results.includes(:state => :country)
        results &= country_class.like(country) & state_class.like(state)
      elsif !state.blank?
        results = results.includes(:state)
        results &= state_class.like(state)
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