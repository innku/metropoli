module Metropoli
  module ConfigurationHelper
    protected
    def city_class
      eval(Metropoli.city_class)
    end
    
    def state_class
      eval(Metropoli.state_class)
    end
    
    def country_class
      eval(Metropoli.country_class)
    end
    
    def city_json_values
      Metropoli.city_autocomplete_fields.split(',').map(&:strip).map(&:to_sym)
    end
    
    def state_json_values
      Metropoli.state_autocomplete_fields.split(',').map(&:strip).map(&:to_sym)
    end
    
    def country_json_values
      Metropoli.country_autocomplete_fields.split(',').map(&:strip).map(&:to_sym)
    end
    
    def city_json_methods
      Metropoli.city_json_extra_methods.split(',').map(&:strip).map(&:to_sym)
    end
    
    def state_json_methods
      Metropoli.state_json_extra_methods.split(',').map(&:strip).map(&:to_sym)
    end
    
    def country_json_methods
      Metropoli.country_json_extra_methods.split(',').map(&:strip).map(&:to_sym)
    end
    
    def self.relation_class_for(name)
      name = name.to_s
      name.downcase!
      case name
        when /city|cities/ then Metropoli.city_class
        when /state|states/ then Metropoli.state_class
        when /country|countries/ then Metropoli.country_class
      end
    end
    
    def self.relation_name_for(related_class, relation_type = 'belongs_to')
      if !related_class.nil?
        related_class.downcase
      else
        if relation_type == 'belongs_to'
          return'city'
        else
          return 'cities'
        end
      end
    end
    
  end
end