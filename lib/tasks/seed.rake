require 'csv'
require 'metropoli/seed_helper'

namespace :metropoli do
  task :seed => :environment do 
    begin
      puts 'Loading migration files..'
      countries = CSV.open(RAILS_ROOT + 'db/csv/countries.csv', :headers => true)
      states = CSV.open(RAILS_ROOT + 'db/csv/states.csv', :headers => true)
      cities = CSV.open(RAILS_ROOT + 'db/csv/cities.csv', :headers => true)
      puts 'Files loaded.'
    rescue
      puts 'There was an error opening your CSV data Files. Please check the documentation.'
    end
    
    begin 
      include Metropoli::SeedHelper
      
      migrate_from_csv(Metropoli::Country, countries)
      migrate_from_csv(Metropoli::State, states)
      migrate_from_csv(Metropoli::City, cities)
      
    rescue Exception => e
      puts 'There was an error processing your files'
      puts e.message
    end
    
  end
end