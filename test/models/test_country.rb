# -*- encoding: utf-8 -*-
require 'helper'

class TestCountry < Test::Unit::TestCase
  include Metropoli
  extend Shoulda::ActiveRecord::Matchers

  def setup
    @mexico  = CountryModel.find_by_name('Mexico')
    @bolivia = CountryModel.find_by_name('Bolivia')
    @shoulda_subject = CountryModel.new
  end

  should have_many(:states).dependent(:destroy)

  context 'quering countries' do
    should 'find country by name' do
      assert_equal [@mexico],  CountryModel.like('Mexico') 
      assert_equal [@bolivia], CountryModel.like('Bolivia')
    end

    should 'find country by incomplete name' do
      assert_equal [@mexico],  CountryModel.like('Mex') 
      assert_equal [@bolivia], CountryModel.like('Bol')
    end

    should 'find all countries with blank query' do
      assert_equal [@mexico, @bolivia], Metropoli::CountryModel.like('') 
      assert_equal [@mexico, @bolivia], Metropoli::CountryModel.like(nil) 
    end

    should 'find country by alternate name' do
      assert_equal [@mexico], CountryModel.like('México')
      assert_equal [@mexico], CountryModel.like('Méjico')
    end

    should 'find country by iso code' do
      assert_equal [@mexico], CountryModel.like('MX')
    end

    context 'finding by string' do
      should 'find city by its string representation' do
        assert_equal [@mexico], CountryModel.is("Mexico")
        assert_equal [@mexico], CountryModel.is("MX")
      end

      should 'not allow incomplete names' do
        assert_equal 0, CountryModel.by_string('M').count
        assert_equal 0, CountryModel.by_string('Mexi').count
      end

      should 'not return no results if passing blank' do
        assert_equal 0, CountryModel.by_string('').count
        assert_equal 0, CountryModel.by_string(nil).count
      end
    end
  end

  context 'representations' do
    should 'emit json' do
      assert_equal %({"country":{"id":#{@mexico.id},"to_s":"Mexico"}}), @mexico.to_json
    end

    should 'have custom format for #to_s' do
      assert_equal "Mexico", @mexico.text
      assert_equal "Mexico", @mexico.to_s
    end
  end
end
