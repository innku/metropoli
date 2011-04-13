module Metropoli
  class StateModel < ActiveRecord::Base
    set_table_name  :states
    belongs_to      :country, :class_name => Metropoli.country_class
    has_many        :cities,  :class_name => Metropoli.city_class, :foreign_key => :state_id, :dependent => :destroy

    extend StatementHelper
    extend ConfigurationHelper
    
    def to_s
      "#{self.name}, #{self.country.name}"
    end
    
    def metropoli_json
      self.to_json(:root => :state, 
                   :only => [:id],
                   :methods => [:to_s])
    end

    class << self
      def autocomplete(string)
        state, country = string.to_s.split(',').map(&:strip)
        like(state).includes(:country).merge country_class.like(country)
      end

      def by_string(string)
        state, country = string.to_s.split(',').map(&:strip)

        results = is(state).includes(:country)
        results = results.merge country_class.is(country) if country
        results
      end
    end
  end
end
