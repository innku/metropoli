module Metropoli
  class State < ActiveRecord::Base
    belongs_to  :country
    has_many    :cities
    extend StatementHelper
    
    def self.autocomplete(string)
      state, country = string.split(',').map(&:strip)
      results = State.like(state) unless state.nil?
      results = results.includes(:country) & Country.like(country) unless country.blank?
      results
    end
  
    def self.like(name)
      self.where(like_statement(name))
    end
    
    def to_s
      "#{self.name}, #{self.country.abbr}"
    end

  end
end
