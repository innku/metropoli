module Metropoli
  module Generators
    class MetropoliGenerator < Rails::Generators::Base
      include Rails::Generators::Migration
      argument      :for_model, :type => :string, :banner => 'model'
      argument      :metropoli_model,  :type => :string, :default => 'city', :banner => 'city|state|country'
      class_option  :as, :type => :string, :desc => 'sets a name for the relation different from city, state or country.'
      
      source_root File.expand_path('../templates',__FILE__)
      
      desc 'Generates the relation from one of the applications models to any city, state or country'
      
      def self.next_migration_number(path)
        @seconds = @seconds.nil? ? Time.now.sec : (@seconds + 1)
        @seconds = "0#{@seconds.to_s}" if @seconds < 10
        Time.now.utc.strftime("%Y%m%d%H%M") + @seconds.to_s
      end
      
      def generate_migration
        if is_belongs_to?
          migration_template  'migrate/belongs_to.rb',"db/migrate/add_#{migration_name}_to_#{app_table_name}.rb"
        else
          migration_template  'migrate/has_and_belongs_to_many.rb',
                              "db/migrate/add_#{migration_name}_to_#{app_table_name}.rb"
        end
      end
      
      def show_readme
        puts <<-CONTENT
===============================================================================

To relate your model to the engine copy the following line to your 
#{for_model} model:
   
  metropoli_for   :#{metropoli_model}#{(", :as => '" + options.as + "'") if options.as? }
                
===============================================================================
CONTENT
      end
      
      private
      
      def app_table_name
        for_model.underscore.pluralize
      end
      
      def relation_name
        [app_table_name,(options.as || metropoli_model)].sort.join('_')
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