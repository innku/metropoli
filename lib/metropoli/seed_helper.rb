module Metropoli
  module SeedHelper
    
    def seed_from_yaml(file)
      country_data = YAML.load_file(file)
      states       = country_data.delete('regions')

      country_data['states'] = states.map do |state_data|
        set_alt_names_for state_data
        
        state_data['cities'].map! do |city_data|
          set_alt_names_for city_data
          CityModel.new city_data
        end

        StateModel.new state_data
      end

      set_alt_names_for country_data
      CountryModel.create country_data
    end

    private
    def set_alt_names_for hash
      hash['alternate_names']  ||= [] 
      hash.delete_if{ |key, val| hash['alternate_names'] << val if /names_\w{2}/ === key }
      hash['alternate_names'] = hash['alternate_names'].empty? ? nil : hash['alternate_names'].flatten.uniq.join(', ')
    end
  end
end
