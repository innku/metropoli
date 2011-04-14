module Metropoli
  class StateModel < ActiveRecord::Base
    extend StatementHelper

    set_table_name  :states
    belongs_to      :country, :class_name => Metropoli.country_class
    has_many        :cities,  :class_name => Metropoli.city_class, :foreign_key => :state_id, :dependent => :destroy
    
    def to_s
      "#{self.name}, #{self.country.name}"
    end
    alias :text :to_s
    
    def as_json opts = {}
      super({:root => :state, :only => [:id], :methods => [:to_s]}.merge(opts || {})) 
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
