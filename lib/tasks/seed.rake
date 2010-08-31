# encoding: UTF-8

#Use appropriate ruby library
if VERSION.include?('1.9')
  require 'csv'
  csv_class = CSV
else
  require 'fastercsv'
  csv_class = FasterCSV
end

namespace :metropoli do
  task :seed => :environment do 
    begin
      countries = csv_class.open(Rails.root + 'db/csv/countries.csv', :headers => true)
      states = csv_class.open(Rails.root + 'db/csv/states.csv', :headers => true)
      cities = csv_class.open(Rails.root + 'db/csv/cities.csv', :headers => true)
      puts 'Files loaded.'
    rescue
      puts 'There was an error opening your CSV data Files. Please check the documentation.'
    end
    
    begin 
      include Metropoli::SeedHelper
      # encoding: UTF-8
      puts 'Loading countries..'
      migrate_from_csv(Metropoli::CountryModel, countries)
      puts 'Loading states..'
      migrate_from_csv(Metropoli::StateModel, states)
      puts 'Loading cities..'
      migrate_from_csv(Metropoli::CityModel, cities)
      
    rescue Exception => e
      puts 'There was an error processing your files'
      puts e.message
    end
    
  end
end