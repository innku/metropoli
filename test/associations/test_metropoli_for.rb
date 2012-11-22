require 'helper'

class TestMetropoliFor < ActiveSupport::TestCase
  
  def setup
    @user_class = User
    @mty = Metropoli::CityModel.find_by_name('Monterrey')
    @mty_similar = Factory(:city, :name => 'Monte carlo')
  end
  
  test 'it should associate with city when called' do
    @user_class.metropoli_for  :city
    new_user = @user_class.new
    assert_nil new_user.city
  end
  
  test 'it should associate with the given models' do
    @user_class.metropoli_for  :city
    @user_class.metropoli_for  :state
    @user_class.metropoli_for  :country
    assert_equal @user_class.new.build_city.class.to_s, 'Metropoli::CityModel'
    assert_equal @user_class.new.build_state.class.to_s, 'Metropoli::StateModel'
    assert_equal @user_class.new.build_country.class.to_s, 'Metropoli::CountryModel'
  end
  
  test 'it should associate with city when called with alias' do
    @user_class.metropoli_for  :city, :as => :origin
    new_user = @user_class.new
    assert_nil new_user.origin
  end
  
  test 'it should find the city with the string provided' do
    @user_class.metropoli_for  :city
    new_user = @user_class.new
    new_user.city_name = 'Monterrey'
    assert_equal new_user.city, @mty
  end
  
  test 'it should find the city with the string provided for alias' do
    @user_class.metropoli_for  :city, :as => :origin
    new_user = @user_class.new
    new_user.origin_name = 'Monterrey'
    assert_equal new_user.origin, @mty
  end
  
  test 'it shouldnt set the city when not found' do
    @user_class.metropoli_for  :city
    new_user = @user_class.new
    new_user.city_name = 'no_place'
    assert_nil new_user.city, @mty
  end
  
  test 'it shouldnt set the city when nil is the string provided' do
    @user_class.metropoli_for  :city
    new_user = @user_class.new
    new_user.city_name = nil
    assert_nil new_user.city, @mty
  end
  
  test 'it shouldnt set the city if a lot of cities are found' do
    @user_class.metropoli_for  :city
    new_user = @user_class.new
    new_user.city_name = 'Mon'
    assert_nil new_user.city
  end
  
  test 'it shouldnt be valid if the city is required and no city is assigned' do
    @user_class.metropoli_for  :city, :required => true
    new_user = @user_class.new
    assert !new_user.valid?
  end
  
  test 'it shouldnt be valid if the city is required with a filter and the filter is true' do
    @user_class.metropoli_for  :city, :required_if => :true
    new_user = @user_class.new
    assert !new_user.valid?
  end
  
  test 'it should be valid if the city is required with a filter, city is nil and the filter is false' do
    @user_class.metropoli_for  :city, :required_if => :false
    new_user = @user_class.new
    assert new_user.valid?
  end
  
  test 'it shouldnt be valid if the city is required and no city is found' do
    @user_class.metropoli_for  :city, :required => true
    new_user = @user_class.new
    new_user.city_name = 'invalid_place'
    assert !new_user.valid?
    assert new_user.errors[:city].include?(Metropoli::Messages.error(:city, :couldnt_find))
  end
  
  test 'it shouldnt be valid if the city is required and too many cities are found' do
    @user_class.metropoli_for  :city, :required => true
    new_user = @user_class.new
    new_user.city_name = 'mon'
    assert !new_user.valid?
    #FIXME assert new_user.errors[:city].include?(Metropoli::Messages.error(:city, :found_too_many))
  end
  
  test 'the city_name method should be the verbose city name' do
    @user_class.metropoli_for  :city
    new_user = @user_class.new
    new_user.city_name = 'Monterrey'
    new_user.save
    assert_equal @user_class.last.city_name, @mty.to_s
  end
  
  
end
