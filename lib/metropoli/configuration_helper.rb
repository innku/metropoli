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
    
    def relation_class_for(name)
      case name
        when 'city' then Metropoli.city_class_name
        when 'state' then Metropoli.state_class_name
        when 'country' then Metropoli.country_class_name
      end
    end
    
  end
end