module Metropoli
  module Generators
    class MetropoliGenerator < Rails::Generators::Base
      include Rails::Generators::Migration
      argument      :for_model, :type => :string
      argument      :metropoli_model,  :type => :string, :default => 'city'
      class_option  :as, :type => :string
      
      source_root File.expand_path('../templates',__FILE__)
      
      def self.next_migration_number(path)
        @seconds = @seconds.nil? ? Time.now.sec : (@seconds + 1)
        Time.now.utc.strftime("%Y%m%d%H%M") + @seconds.to_s
      end
      
      def generate_migration
        if is_belongs_to?
          migration_template  'migrate/belongs_to.rb',"db/migrate/add_#{migration_name}_to_#{app_table_name}.rb"
        else
          migration_template  'migrate/has_many.rb',"db/migrate/add_#{migration_name}_to_#{app_table_name}.rb"
        end
      end
      
      def show_readme
        readme "README"
      end
      
      private
      
      def app_table_name
        for_model.underscore.pluralize
      end
      
      def relation_name
        [app_table_name,metropoli_model].sort.join('_')
      end
      
      def is_belongs_to?
        metropoli_model == metropoli_model.singularize
      end
      
      def migration_name
        if options.as?
          options.as.split(',').join('_and_')
        else
          metropoli_model
        end
      end
      
      def relation_aliases
        if options.as?
          options.as.split(',')
        else
          [metropoli_model]
        end
      end
      
      def metropoli_relation
        if options.as?
          options.as.singularize
        else
          metropoli_model.singularize
        end
      end
      
    end
  end
end