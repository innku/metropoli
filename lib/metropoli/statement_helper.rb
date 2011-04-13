#TODO Refactoring to set this values only once per application start

module Metropoli
  module StatementHelper
    extend ConfigurationHelper

    def autocomplete_fields
      Metropoli.send("#{table_name.singularize}_autocomplete_fields").split(',').map(&:strip)
    end

    def like(name)
      return where(arel_table[:id].gt(0)) if name.blank? # all models
      where autocomplete_fields.inject(arel_table[:name].eq(name)) { |query, field| query.or arel_table[field].matches("%#{name}%")  }
    end

    def is(name)
      return where(arel_table[:id].lt(0)) if name.blank? # no models
      where autocomplete_fields.inject(arel_table[:name].eq(name)) { |query, field| query.or arel_table[field].eq(name)  }
    end
  end
end
