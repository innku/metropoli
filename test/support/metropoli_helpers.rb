module Metropoli
  module Helpers
    
    def self.return_to_defaults
      Metropoli.city_class = 'Metropoli::CityModel'
      Metropoli.state_class = 'Metropoli::StateModel'
      Metropoli.country_class = 'Metropoli::CountryModel'
      Metropoli.city_autocomplete_fields = 'name'
      Metropoli.state_autocomplete_fields = 'name,abbr'
      Metropoli.country_autocomplete_fields = 'name,abbr'
    end
    
    def self.set_custom_classes
      Metropoli.city_class = 'City'
      Metropoli.state_class = 'State'
      Metropoli.country_class = 'Country'
    end
    
  end
end