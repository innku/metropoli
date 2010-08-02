ENV["RAILS_ENV"] = "test"

require 'rubygems'
require 'factory_girl'
require 'factories'
require 'test/unit'
require "test_app/config/environment"
require "rails/test_help"

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

# Add support to load paths so we can overwrite broken webrat setup
$:.unshift File.expand_path('../support', __FILE__)
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }