module Metropoli
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration
      
      source_root File.expand_path('../templates',__FILE__)
      
      def self.next_migration_number(path)
        @seconds = @seconds.nil? ? Time.now.sec : (@seconds + 1)
        Time.now.utc.strftime("%Y%m%d%H%M") + @seconds.to_s
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
      
      def generate_locale
        copy_file 'locales/en.yml', 'config/locales/metropoli.en.yml' 
      end
      
      def readme
        readme 'README'
      end 
      
    end
  end
end