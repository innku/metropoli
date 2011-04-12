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
