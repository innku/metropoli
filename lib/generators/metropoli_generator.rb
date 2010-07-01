module Metropoli
  module Generators
    class MetropoliGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates',__FILE__)
      
      def generate_migration
        copy_file 'migrate/create_metropoli.rb', 'db/migrate/create_metropoli.rb'
      end
      
    end
  end
end