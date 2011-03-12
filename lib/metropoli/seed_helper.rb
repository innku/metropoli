module Metropoli
  module SeedHelper
    def migrate_from_csv(migration_class, csv_file)
      migration_class.transaction do
        csv_file.each do |line_values|
          record = migration_class.new
          if RUBY_VERSION.include?('1.9')
            line_values.to_hash.keys.map{|attribute| record.send("#{attribute}=",utf8(line_values[attribute])) }
          else
            line_values.to_hash.keys.map{|attribute| record.send("#{attribute}=",line_values[attribute]) }
          end
          record.save(:validate => false)
        end
      end
    end
    
    def utf8(string)
      string.force_encoding('utf-8') unless string.nil?
    end
  end
end