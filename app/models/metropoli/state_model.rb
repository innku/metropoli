module Metropoli
  class StateModel < ActiveRecord::Base
    set_table_name  :states
    belongs_to      :country, :class_name => Metropoli.country_class
    has_many        :cities,  :class_name => Metropoli.city_class, :foreign_key => :state_id
    extend StatementHelper
    extend ConfigurationHelper
    
    def self.autocomplete(string='')
      string ||= ''
      state, country = string.split(',').map(&:strip)
      results = self.like(state)
      results = results.includes(:country).merge(country_class.like(country)) unless country.blank?
      results
    end
  
    def self.like(name)
      self.where(like_statement(name))
    end
    
    def self.is(name)
      self.where(find_statement(name))
    end
    
    def self.with_values(string='')
      string ||=""
      results = []
      state, country = string.split(',').map(&:strip)
      unless state.blank?
        results = self.is(state)
        results = results.includes(:country) & country_class.is(country) unless country.blank?
      end
      results
    end
    
    def to_s
      "#{self.name}, #{self.country.name}"
    end
    
    def metropoli_json
      self.to_json(:root => :state, 
                   :only => [:id],
                   :methods => [:to_s])
    end
    
  end
end
