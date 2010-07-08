module Metropoli
  
  mattr_accessor  :country_class
  @@country_class = 'Metropoli::CountryModel'
  
  mattr_accessor  :state_class
  @@state_class = 'Metropoli::StateModel'
  
  mattr_accessor  :city_class
  @@city_class = 'Metropoli::CityModel'
  
  mattr_accessor  :country_autocomplete_fields
  @@country_autocomplete_fields = 'name, abbr'
  
  mattr_accessor  :state_autocomplete_fields
  @@state_autocomplete_fields = 'name, abbr'
  
  mattr_accessor  :city_autocomplete_fields
  @@city_autocomplete_fields = 'name, alt_name'
  
  def self.setup
    yield self
  end
  
  if defined?(Rails) && Rails::VERSION::MAJOR == 3
    require 'metropoli/associations'
    require 'metropoli/statement_helper'
    require 'metropoli/seed_helper'
    require 'metropoli/engine' 
  end
  
end