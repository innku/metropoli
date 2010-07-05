module Metropoli
  module Generators
    class MetropoliGenerator < Rails::Generators::Base
      include Rails::Generators::Migration
      argument    :for_model, :type => :string
      argument    :to_model,  :type => :string, :default => 'city'
      
      source_root File.expand_path('../templates',__FILE__)
      
      def self.next_migration_number(path)
        @seconds = @seconds.nil? ? Time.now.sec : (@seconds + 1)
        Time.now.utc.strftime("%Y%m%d%H%M") + @seconds.to_s
      end
      
      def generate_migration
        if is_belongs_to?
          migration_template  'migrate/belongs_to_migration.rb',"db/migrate/add_#{to_model}_to_#{model_name}.rb"
        else
          migration_template  'migrate/has_many_migration.rb',"db/migrate/add_#{to_model}_to_#{model_name}.rb"
        end
      end
      
      private
      
      def model_name
        for_model.underscore.pluralize
      end
      
      def relation_name
        [model_name,to_model].sort.join('_')
      end
      
      def is_belongs_to?
        to_model == to_model.singularize
      end
      
    end
  end
end