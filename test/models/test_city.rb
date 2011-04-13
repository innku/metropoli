# -*- encoding: utf-8 -*-
require 'helper'

class TestCity < ActiveSupport::TestCase
  include Metropoli
  extend Shoulda::ActiveRecord::Matchers

  def setup
    @monterrey       = CityModel.find_by_name('Monterrey')
    @merida          = CityModel.find_by_name('Mérida')
    @shoulda_subject = CityModel.new
  end

  should belong_to(:state)
  
  should 'delegate country' do
    assert_equal 'Mexico', @monterrey.country.name
  end

  context 'quering cities' do
    should 'find city by name' do
      assert_equal [@monterrey], CityModel.like('Monterrey')
      assert_equal [@merida],    CityModel.like('Mérida')
    end

    should 'find city by ascii name' do
      assert_equal [@merida], CityModel.like('Merida')
    end

    should 'find city by alternate name' do
      assert_equal [@monterrey], CityModel.like('Monterejo')
    end

    should 'find city with incomplete name' do
      assert_equal [@monterrey], CityModel.like('Monterr')
    end

    should 'find all cities when query is blank' do
      assert_equal CityModel.count, CityModel.like('').count
      assert_equal CityModel.count, CityModel.like(nil).count
    end

    context 'finding by string' do
      should 'find city by its string representation' do
        assert_equal [@monterrey], CityModel.by_string(@monterrey.to_s)
        assert_equal [@monterrey], CityModel.by_string("Monterrey, Nuevo León")
        assert_equal [@monterrey], CityModel.by_string("Monterrey")
      end

      should 'use autocomplete fields' do
        assert_equal [@monterrey], CityModel.by_string('Monterrey, Nuevo Leon, MX')
      end

      should 'not allow incomplete names' do
        assert_equal 0, CityModel.by_string('Monter, Nuevo Leon, MX').count
        assert_equal 0, CityModel.by_string('Monterrey, Nuevo Le, MX').count
        assert_equal 0, CityModel.by_string('Monterrey, Nuevo Leon, M').count
      end

      should 'not return no results if passing blank' do
        assert_equal 0, CityModel.by_string('').count
        assert_equal 0, CityModel.by_string(nil).count
      end
    end

    context 'autocomplete' do
      should 'find cities with state' do
        assert_equal [@monterrey], CityModel.autocomplete('Monterrey, Nuevo Leon')
        assert_equal [@monterrey], CityModel.autocomplete('Monterrey, Nuevo León')
        assert_equal [@monterrey], CityModel.autocomplete('Monterrey, NLE')
      end

      should 'not find if state is not correct' do
        assert_equal 0, CityModel.autocomplete('Monterrey, Yucatán').count
      end

      should 'find cities with state and country' do
        assert_equal [@monterrey], CityModel.autocomplete('Monterrey, Nuevo Leon, MX')
        assert_equal [@monterrey], CityModel.autocomplete('Monterrey, Nuevo León, México')
        assert_equal [@monterrey], CityModel.autocomplete('Monterrey, NLE, Mx')
        assert_equal [@monterrey], CityModel.autocomplete('Monterrey, NLE, México')
      end

      should 'not find if state is not correct' do
        assert_equal 0, CityModel.autocomplete('Monterrey, Nuevo Leon, Cuba').count
      end

      should 'find all cities when query is blank' do
        assert_equal CityModel.count, CityModel.autocomplete('').count
        assert_equal CityModel.count, CityModel.autocomplete(nil).count
      end

      should 'order by population' do
        assert_equal CityModel.autocomplete(nil).limit(10), CityModel.all.sort_by(&:population).reverse[0..9]
      end
    end
  end

  context 'representations' do
    should 'emit json' do
      skip
    end

    should 'have custom format for #to_s' do
      skip
    end
  end
end
