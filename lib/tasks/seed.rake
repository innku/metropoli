require 'csv'
require 'lib/seed_helper'

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
      # countries.each do |country_values|
      #   country_record = Metropoli::Country.new
      #   country_values.to_hash.keys.map{|attribute|country_record.send("#{attribute}=",country_values[attribute])}
      #   country_record.save(false)
      # end
      # 
      # states.each do |state_values|
      #   state_record = Metropoli::State.new
      #   state_values.to_hash.keys.map{|attribute|state_record.send("#{attribute}=",state_values[attribute])}
      #   state_record.save(false)
      # end
      # 
      # cities.each do |city_values|
      #   city_record = Metropoli::City.new
      #   city_values.to_hash.keys.map{|attribute|city_record.send("#{attribute}=",city_values[attribute])}
      #   city_record.save  (false)
      # end
      
      migrate_from_csv(Metropoli::Country, countries)
      
    rescue Exception => e
      puts 'There was an error processing your files'
      puts e.message
    end
    
  end
end