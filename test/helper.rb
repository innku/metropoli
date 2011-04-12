ENV["RAILS_ENV"] = "test"

require 'rubygems'

require 'factory_girl'
require 'shoulda'
require 'shoulda/active_record/matchers'
require 'factories'
require 'test_app/config/environment'
require 'rails/test_help'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

# load fixtures
include Metropoli::SeedHelper

seed_from_yaml File.join(File.dirname(__FILE__), 'support', 'mexico.yml')
seed_from_yaml File.join(File.dirname(__FILE__), 'support', 'bolivia.yml')
