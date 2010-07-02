module Metropoli
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration
      
      source_root File.expand_path('../templates',__FILE__)
      
      def self.next_migration_number(path)
        Time.now.utc.strftime("%Y%m%d%H%M%S")
      end
      
      def generate_countries
        migration_template 'migrate/create_metropoli_countries.rb', 'db/migrate/create_metropoli_countries.rb'
      end
      
      def generate_states
        migration_template 'migrate/create_metropoli_states.rb', 'db/migrate/create_metropoli_states.rb'
      end
      
      def generate_cities
        migration_template 'migrate/create_metropoli_cities.rb', 'db/migrate/create_metropoli_cities.rb'
      end
      
    end
  end
end