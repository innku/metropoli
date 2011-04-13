# -*- encoding: utf-8 -*-
require 'helper'

class TestMetropoliForMany < ActiveSupport::TestCase
  include Metropoli
  extend Shoulda::ActiveRecord::Matchers
  
  context 'metropoli association with many' do
    setup do
      Object.remove_const(:User) if Object.const_defined? :User
      class User < ActiveRecord::Base
        def true; true end
        def false; false end
      end
      @monterrey  = CityModel.find_by_name('Monterrey')
      @nuevo_leon = StateModel.find_by_name('Nuevo León')
      @mexico     = CountryModel.find_by_name('Mexico')
    end

    context 'without options' do
      setup do
        User.metropoli_for_many  :cities
        User.metropoli_for_many  :states
        User.metropoli_for_many  :countries
        @user = @shoulda_subject = User.new
      end

      should have_and_belong_to_many :cities
      should have_and_belong_to_many :states
      should have_and_belong_to_many :countries

      should 'build associations' do
        assert_equal Metropoli::CityModel,    @user.cities.build.class    
        assert_equal Metropoli::StateModel,   @user.states.build.class   
        assert_equal Metropoli::CountryModel, @user.countries.build.class 
      end

      context 'assigning by name' do
        setup do
          @user.add_country 'Mexico'
          @user.add_state 'Nuevo León'
          @user.add_city 'Monterrey'
        end

        should 'assign relationship by name' do
          assert_equal [@mexico], @user.countries
          assert_equal [@nuevo_leon], @user.states
          assert_equal [@monterrey], @user.cities
        end

        should 'not assign if non existant' do
          @user.add_country 'invalid'
          @user.add_state 'invalid'
          @user.add_city 'invalid'
          assert_equal [@mexico], @user.countries
          assert_equal [@nuevo_leon], @user.states
          assert_equal [@monterrey], @user.cities
        end

        should 'remove associations' do
          @user.remove_country 'Mexico'
          @user.remove_state 'Nuevo León'
          @user.remove_city 'Monterrey'
          assert_blank @user.countries
          assert_blank @user.states
          assert_blank @user.cities
        end

        should 'not remove if not present' do
          @user.remove_country 'invalid'
          @user.remove_state 'invalid'
          @user.remove_city 'invalid'
          assert_equal [@mexico], @user.countries
          assert_equal [@nuevo_leon], @user.states
          assert_equal [@monterrey], @user.cities
        end

        # should 'allow repeated if not passing unique' do
        #   User.metropoli_for_many :countries
        #   @user.countries << @mexico
        #   assert_equal [@mexico]*2, @user.countries
        # end

        should 'not add a model if its already there and metropoli specifies unique' do
          User.metropoli_for_many :countries, :unique => true
          @user.countries << @mexico
          assert_equal [@mexico], @user.countries
        end
      end
    end

    context 'with alias' do
      setup do
        User.metropoli_for_many  :cities,    :as => :towns
        User.metropoli_for_many  :states,    :as => :regions
        User.metropoli_for_many  :countries, :as => :nations
        @user = @shoulda_subject = User.new
      end

      should 'build associations' do
        assert_equal Metropoli::CityModel,    @user.towns.build.class    
        assert_equal Metropoli::StateModel,   @user.regions.build.class   
        assert_equal Metropoli::CountryModel, @user.nations.build.class 
      end

      should 'assign relationship by name' do
        @user.add_nation 'Mexico'
        @user.add_region 'Nuevo León'
        @user.add_town 'Monterrey'
        assert_equal [@mexico], @user.nations
        assert_equal [@nuevo_leon], @user.regions
        assert_equal [@monterrey], @user.towns
      end
    end
    
    context 'validations' do
      should 'be valid within range' do
        User.metropoli_for_many  :cities, :required => true, :max => 2
        user = User.new :cities => CityModel.limit(2)
        assert_equal 2, user.cities.size
        assert user.valid?
      end

      should 'validate max city count' do
        User.metropoli_for_many  :cities, :required => true, :max => 2
        user = User.new :cities => CityModel.limit(3)
        assert_equal 3, user.cities.size
        assert !user.valid?
        assert user.errors[:cities].include?(Metropoli::Messages.error(:city, :too_many))
      end

      should 'be invalid if metropoli is required and not added' do
        User.metropoli_for_many  :cities, :required => true
        user = User.new
        assert !user.valid?
        assert user.errors[:cities].include?(Metropoli::Messages.error(:city, :not_enough))
      end

      should 'validate min count' do
        User.metropoli_for_many  :cities, :required => true, :min => 2
        user = User.new :cities => CityModel.limit(1)
        assert_equal 1, user.cities.size
        assert !user.valid?
        assert user.errors[:cities].include?(Metropoli::Messages.error(:city, :not_enough))
      end
    end
  end
end
