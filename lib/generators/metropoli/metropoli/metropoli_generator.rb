module Metropoli
  module Generators
    class MetropoliGenerator < Rails::Generators::Base
      include Rails::Generators::Migration
      argument    :for_model
      source_root File.expand_path('../templates',__FILE__)
      
      def self.next_migration_number(path)
        @seconds = @seconds.nil? ? Time.now.sec : (@seconds + 1)
        Time.now.utc.strftime("%Y%m%d%H%M") + @seconds.to_s
      end
      
      def generate_migration
        migration_template 'migrate/add_metropoli_to_model.rb', "db/migrate/add_metropoli_to_#{model_name}.rb"
      end
      
      private
      
      def model_name
        for_model.undescore.pluralize
      end
      
    end
  end
end