# encoding: UTF-8

namespace :metropoli do
  desc 'Seeds the city database with the csv files in db/csv'

  task :seed => :environment do 
    include Metropoli::SeedHelper
    Dir.glob(Rails.root.join('db', 'metropoli_seeds', '*')).each { |file| seed_from_yaml file }
  end
  
  desc 'Cleans up the city database in case of error'
  task :cleanup => :environment do
    puts 'Cleaning up...'
      Metropoli::CountryModel.destroy_all
      Metropoli::StateModel.destroy_all
      Metropoli::CityModel.destroy_all
    puts 'Finished'
  end

  desc 'List all available countries'
  task :countries => :environment do
    Metropoli::COUNTRIES.each { |iso, name| puts "#{iso} #{name}" }
  end
end
