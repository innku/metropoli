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
      assert_equal 'Bolivia', @country.name
    end

    should 'save states' do
      assert_equal 4, StateModel.count
      assert_equal 2, @country.states.size
    end

    should 'set fields for state' do
      assert_equal 'Cochabamba', @state.name
      assert_equal 2, @state.cities.count
    end

    should 'set fields for city' do
      city = @state.cities.first
      assert_equal 'Cochabamba', city.name
    end
  end
end
