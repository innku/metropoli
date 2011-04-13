module Metropoli
  module Helpers
    def self.return_to_defaults
      load File.expand_path File.join(File.dirname(__FILE__), '..', '..', 'lib', 'metropoli.rb')
    end
    
    def self.set_custom_classes
      Metropoli.city_class = 'City'
      Metropoli.state_class = 'State'
      Metropoli.country_class = 'Country'
    end
  end
end
