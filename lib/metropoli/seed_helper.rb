module Metropoli
  module SeedHelper
    def migrate_from_csv(migration_class, csv_file)
      migration_class.transaction do
        csv_file.each do |line_values|
          record = migration_class.new
          line_values.to_hash.keys.map{|attribute| record.send("#{attribute}=",line_values[attribute])}
          record.save(false)
        end
      end
    end
  end
end