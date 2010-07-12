#ENV["RAILS_ENV"] = "test"

require 'rubygems'
require 'test/unit'
require 'shoulda'
require 'rails'
require 'active_record'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'metropoli'

class Test::Unit::TestCase
end
