Metropoli.setup do |config|
  #
  ## Uncomment and change if your want to extend behaviour of a class
  ## with your own class
  ##
  ## Example config.city_class = 'City'
  
  # config.city_class = 'Metropoli::CityModel'
  
  # config.state_class = 'Metropoli::StateModel'
  
  # config.country_class = 'Metropoli::CountryModel'
  
  
  ## Change if you want to add fields or rename the fields
  ## in which the autocomplete searches for cities, states or countries
  ##
  ## Example. config.city_autocomplete_fields = 'name, capital_name, ascii_name'
  
  # config.city_autocomplete_fields = 'name, ascii_name, alternate_names'
  
  # config.state_autocomplete_fields = 'name, abbr, ascii_name, alternate_names'
  
  # config.country_autocomplete_fields = 'name, abbr, alternate_names, iso'
  
  
  ## Changes autocomplete limit default 
  ## 
  ## Example config.autocomplete_limit = 10
  
  # config.autocomplete_limit = 20
end
