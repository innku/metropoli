module Metropoli
  class City < ActiveRecord::Base    
    extend StatementHelper
    belongs_to  :state
    delegate    :country, :to => :state
    
    def self.autocomplete(string)
      city, state, country = string.split(',').map(&:strip)
      results = City.like(city) unless city.nil?
      if !country.blank?
        results = results.includes(:state => :country)
        results &= Country.like(country) & State.like(state)
      elsif !state.blank?
        results = results.includes(:state)
        results &= State.like(state)
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