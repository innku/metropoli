#TODO Refactoring to set this values only once per application start

module Metropoli
  module StatementHelper
    def autocomplete_fields
      Metropoli.send("#{class_name}_autocomplete_fields").split(',').map(&:strip)
    end

    def class_name
      model_name.to_s.gsub(/Metropoli::|Model/, '').to_s.downcase
    end

    def like(name)
      return where(arel_table[:id].gt(0)) if name.blank? # all models
      where autocomplete_fields.inject(arel_table[:name].eq(name)) { |query, field| query.or arel_table[field].matches("%#{name}%")  }
    end

    def is(name)
      return where(arel_table[:id].gt(0)) if name.blank?
      where autocomplete_fields.inject(arel_table[:name].eq(name)) { |query, field| query.or arel_table[field].eq(name)  }
    end

  end
end
