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
  
  mattr_accessor  :city_json_extra_methods
  @@city_json_extra_methods = ''
  
  mattr_accessor  :state_json_extra_methods
  @@state_json_extra_methods = ''
  
  mattr_accessor  :country_json_extra_methods
  @@country_json_extra_methods = ''
  
  def self.setup
    yield self
  end
  
  if defined?(Rails) && Rails::VERSION::MAJOR == 3
    require 'metropoli/statement_helper'
    require 'metropoli/configuration_helper'
    require 'metropoli/seed_helper'
    require 'metropoli/associations'
    require 'metropoli/engine' 
  end
  
end