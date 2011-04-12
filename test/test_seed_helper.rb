# encoding: UTF-8

require 'helper'
require 'metropoli/seed_helper'

class TestSeedHelper < Test::Unit::TestCase
  include Metropoli

  context 'seeding from a country' do
    setup do
      @country = CountryModel.first
      @state   = StateModel.first
    end
      
    should 'save a country' do
      assert_equal 2, CountryModel.count
      assert_equal 'Mexico', @country.name
      assert_equal "Mexico, Estados Unidos Mexicanos, Méjico, México", @country.alternate_names 
    end

    should 'save states' do
      assert_equal 32, StateModel.count
      assert_equal 32, @country.states.size
    end

    should 'set fields for state' do
      assert_equal 'Yucatán', @state.name
      assert_equal 'Yucatán', @state.alternate_names
      assert_equal 'Yucatan', @state.ascii_name
      assert_equal 72,        @state.cities.count
    end

    should 'set fields for city' do
      city = @state.cities.first
      assert_equal 'Valladolid', city.name
      assert_equal 'Valladolid', city.ascii_name
      assert_equal 39663,        city.population
      assert_nil city.alternate_names
    end
  end
end
