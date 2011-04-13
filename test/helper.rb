ENV["RAILS_ENV"] = "test"

require 'rubygems'

require 'shoulda'
require 'shoulda/active_record/matchers'
require 'test_app/config/environment'
require 'rails/test_help'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

# load fixtures
include Metropoli::SeedHelper

seed_from_yaml File.join(File.dirname(__FILE__), 'support', 'mexico.yml')
seed_from_yaml File.join(File.dirname(__FILE__), 'support', 'bolivia.yml')

def swap(object, new_values)
  old_values = {}
  new_values.each do |key, value|
    old_values[key] = object.send key
    object.send :"#{key}=", value
  end
  yield
ensure
  old_values.each do |key, value|
    object.send :"#{key}=", value
  end
end
