module Metropoli
  class CityModel < ActiveRecord::Base    
    set_table_name  :cities
    extend StatementHelper
    extend ConfigurationHelper
    
    belongs_to      :state,   :class_name => Metropoli.state_class
    delegate        :country, :to => :state
    
    def self.autocomplete(string='')
      string||=''
      city, state, country = string.split(',').map(&:strip)
      results = self.like(city)
      results = results.includes(:state => :country)
      if !country.blank?
        results = results.merge(country_class.like(country))
        results = results.merge(state_class.like(state))
      elsif !state.blank?
        results = results.merge(state_class.like(state))
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
      string ||=""
      city, state, country = string.split(',').map(&:strip)
      results = []
      unless city.blank?
        results = self.is(city)
        results = results.includes(:state => :country)
        if !country.blank?
          results = results.merge(country_class.is(country))
          results = results.merge(state_class.is(state))
        elsif !state.blank?
          results = results.merge(state_class.is(state))
        end
      end
      results
    end
    
    def to_s
      "#{self.name}, #{self.state.name}, #{self.country.abbr}"
    end
    
    def as_json(opts={})
      opts ||={}
      super(opts.merge({ :only => [:id], :methods => [:to_s] }))
    end
  
  end
end
