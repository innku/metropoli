require 'helper'

class TestMetropoliFor < ActiveSupport::TestCase
  include Metropoli
  extend Shoulda::ActiveRecord::Matchers

  context 'associations with metropolis models' do
    setup do
      Object.remove_const(:User) if Object.const_defined? :User
      class User < ActiveRecord::Base
        def true; true end
        def false; false end
      end
      @monterrey = CityModel.find_by_name('Monterrey')
    end

    context 'without options' do
      setup do
        User.metropoli_for  :city
        User.metropoli_for  :state
        User.metropoli_for  :country
        @user = @shoulda_subject = User.new
      end

      should belong_to :city
      should belong_to :state
      should belong_to :country 

      should 'build associations' do
        assert_equal Metropoli::CityModel,    @user.build_city.class    
        assert_equal Metropoli::StateModel,   @user.build_state.class   
        assert_equal Metropoli::CountryModel, @user.build_country.class 
      end

      context 'assigning by city_name attribute' do
        should 'find the city with the string provided' do
          @user.city_name = 'Monterrey'
          assert_equal @monterrey, @user.city
        end

        should 'return city name' do
          assert_nil @user.city_name
          @user.city_name = 'Monterrey'
          assert_equal 'Monterrey', @user.city_name
          @user.save
          assert_equal @monterrey.to_s, User.last.city_name
        end

        should 'not set the city when not found' do
          @user.city_name = 'no_place'
          assert_nil @user.city
        end

        should 'not set the city when nil is the string provided' do
          @user.city_name = nil
          assert_nil @user.city
        end

        should 'unset city when nil is passed as city name' do
          @user.build_city
          @user.city_name = nil
          assert_nil @user.city
        end

        should 'not set the city if a lot of cities are found' do
          @user.city_name = 'Ciudad'
          assert_nil @user.city
        end
      end
    end

    context 'with alias' do
      setup do
        User.metropoli_for  :city,    :as => :town
        User.metropoli_for  :state,   :as => :region
        User.metropoli_for  :country, :as => :nation
        @user = @shoulda_subject = User.new
      end

      should 'build associations' do
        assert_equal Metropoli::CityModel,    @user.build_town.class    
        assert_equal Metropoli::StateModel,   @user.build_region.class   
        assert_equal Metropoli::CountryModel, @user.build_nation.class 
      end

      should 'find the city with the string provided for alias' do
        @user.town_name = 'Monterrey'
        assert_equal @monterrey, @user.town
      end
    end

    context 'validations' do
      should 'validate city presence' do
        User.metropoli_for  :city, :required => true
        user = @shoulda_subject = User.new
        assert !user.valid?
      end

      should 'be valid if the city is required but the filter evals to false' do
        User.metropoli_for  :city, :required_if => :false
        user = @shoulda_subject = User.new
        assert user.valid?
      end

      should 'not be valid if the city is required with a filter and the filter is true' do
        User.metropoli_for :city, :required_if => :true
        user = User.new
        assert !user.valid?
      end

      should 'not be valid if the city is required and no city is found' do
        User.metropoli_for  :city, :required => true
        user = User.new(:city_name => 'invalid_place')
        assert !user.valid?
        assert user.errors[:city].include? Metropoli::Messages.error(:city, :couldnt_find)
      end
      
      should 'not be valid if too many cities are found' do # maybe should be dependent on validation parameter for this single case
        User.metropoli_for :city
        user = User.new(:city_name => 'Alvaro Obregon')
        assert !user.valid?
        assert user.errors[:city].include? Metropoli::Messages.error(:city, :found_too_many)
      end
    end
  end
end
