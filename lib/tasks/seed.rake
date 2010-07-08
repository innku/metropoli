# encoding: UTF-8
require 'csv'
namespace :metropoli do
  task :seed => :environment do 
    begin
      countries = CSV.open(RAILS_ROOT + 'db/csv/countries.csv', :headers => true)
      states = CSV.open(RAILS_ROOT + 'db/csv/states.csv', :headers => true)
      cities = CSV.open(RAILS_ROOT + 'db/csv/cities.csv', :headers => true)
      puts 'Files loaded.'
    rescue
      puts 'There was an error opening your CSV data Files. Please check the documentation.'
    end
    
    begin 
      include Metropoli::SeedHelper
      # encoding: UTF-8
      puts 'Loading countries..'
      migrate_from_csv(Metropoli::Country, countries)
      puts 'Loading states..'
      migrate_from_csv(Metropoli::State, states)
      puts 'Loading cities..'
      migrate_from_csv(Metropoli::City, cities)
      
    rescue Exception => e
      puts 'There was an error processing your files'
      puts e.message
    end
    
  end
end