module Metropoli
  module Generators
    class MetropoliGenerator < Rails::Generators::Base
      include Rails::Generators::Migration
      
      source_root File.expand_path('../templates',__FILE__)
      
      def self.next_migration_number(path)
        Time.now.utc.strftime("%Y%m%d%H%M%S")
      end
      
      def generate_migration
        migration_template 'migrate/create_metropoli.rb', 'db/migrate/create_metropoli.rb'
      end
      
    end
  end
end