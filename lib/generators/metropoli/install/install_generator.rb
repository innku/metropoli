module Metropoli
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration
      class_option  :countries, :type => :array,   :default => %w(MX US), :desc => "List of countries to seed database with, you can select any number of pass 'all', run rake metropoli:countries to see a listing of available countries"
      class_option  :with_jq,   :type => :boolean, :default => false,    :desc => "Copy autocompletion jQuery script"
      
      source_root File.expand_path('../templates',__FILE__)
      
      def self.next_migration_number(path)
        @seconds = @seconds.nil? ? Time.now.sec : (@seconds.to_i + 1)
        @seconds = "0#{@seconds.to_s}" if @seconds < 10
        Time.now.utc.strftime("%Y%m%d%H%M") + @seconds.to_s
      end
      
      def generate_countries
        migration_template 'migrate/1_create_metropoli_countries.rb', 'db/migrate/create_metropoli_countries.rb'
      end
      
      def generate_states
        migration_template 'migrate/2_create_metropoli_states.rb', 'db/migrate/create_metropoli_states.rb'
      end
      
      def generate_cities
        migration_template 'migrate/3_create_metropoli_cities.rb', 'db/migrate/create_metropoli_cities.rb'
      end
      
      def generate_locale
        copy_file 'locales/en.yml', 'config/locales/metropoli.en.yml' 
      end
      
      def generate_initializer
        copy_file 'initializers/metropoli.rb', 'config/initializers/metropoli.rb' 
      end
      
      def generate_yaml_seeds
        countries = options.countries == ['all'] ? Metropoli::COUNTRIES.keys : options.countries
        options.countries.each do |country|
          country = Metropoli::COUNTRIES[country].parameterize rescue raise("#{country} is not registered, run rake metropoli:countries to see a list of available countries")
          say ("Downloading #{country}.yml, this could take a while")
          get "https://github.com/innku/metropoli_places/raw/master/data/#{country}.yml", "tmp/metropoli_seed/#{country}.yml"
        end
      end
      
      def generate_jquery_ui_javascript
        if options.with_jq?
          copy_file 'javascripts/metropoli.jquery.ui.js', 'public/javascripts/metropoli.jquery.ui.js'
        end
      end
      
      def generate_routes
        route 'metropoli_for :cities, :states, :countries'
      end
      
      def show_readme
        readme 'README'
      end 
    end
  end
end
