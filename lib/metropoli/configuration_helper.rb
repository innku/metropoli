module Metropoli
  module ConfigurationHelper
    protected
    def city_class
      Metropoli.city_class.constantize
    end
    
    def state_class
      Metropoli.state_class.constantize
    end
    
    def country_class
      Metropoli.country_class.constantize
    end
    
    # not used
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
    
    def autocomplete_limit
      Metropoli.autocomplete_limit.to_i
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
      return related_class.downcase unless related_class.nil?
      relation_type == 'belongs_to' ? 'city' : 'cities'
    end
  end
end
