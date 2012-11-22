ENV["RAILS_ENV"] = "test"

require 'rubygems'
require 'factory_girl'
require 'factories'
require 'shoulda'
require_relative "test_app/config/environment"
require "rails/test_help"
require 'turn/autorun'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

# Add support to load paths so we can overwrite broken webrat setup
$:.unshift File.expand_path('../support', __FILE__)
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

if RUBY_VERSION.include?('1.9')
  require 'csv'
  csv_class = CSV
else
  require 'fastercsv'  
  csv_class = FasterCSV
end

include Metropoli::SeedHelper
migrate_from_csv City,    csv_class.open("#{File.dirname(__FILE__)}/support/csv/cities.csv", :headers => true)
migrate_from_csv State,   csv_class.open("#{File.dirname(__FILE__)}/support/csv/states.csv", :headers => true)
migrate_from_csv Country, csv_class.open("#{File.dirname(__FILE__)}/support/csv/countries.csv", :headers => true)
