require 'helper'

class TestMetropoliForMany < ActiveSupport::TestCase
  
  def setup
    @user_class = User
    @mty = Factory(:city)
  end
  
  test 'it should associate with cities when called' do
    @user_class.metropoli_for_many  :cities
    new_user = @user_class.new
    assert new_user.cities.empty?
  end
  
  test 'it should associate with metropoli when called with alias' do
    @user_class.metropoli_for_many  :cities, :as => :origins
    new_user = @user_class.new
    assert new_user.origins.empty?
  end
  
  test 'it should add a metropoli location to the model model when found' do
    @user_class.metropoli_for_many  :cities
    @user_class.metropoli_for_many  :states
    @user_class.metropoli_for_many  :countries
    new_user = @user_class.new
    
    assert_difference('new_user.cities.size') do
      new_user.add_city 'Monterrey'
    end
    
    assert_difference('new_user.states.size') do
      new_user.add_state 'Nuevo Leon'
    end
    
    assert_difference('new_user.countries.size') do
      new_user.add_country 'Mexico'
    end

  end
  
  test 'it shouldnt add a metropoli location to the model model when not found' do
    @user_class.metropoli_for_many  :cities
    @user_class.metropoli_for_many  :states
    @user_class.metropoli_for_many  :countries
    new_user = @user_class.new
    
    assert_no_difference('new_user.cities.size') do
      new_user.add_city 'Invalid city'
    end
    
    assert_no_difference('new_user.states.size') do
      new_user.add_state 'Invalid state'
    end
    
    assert_no_difference('new_user.countries.size') do
      new_user.add_country 'Invalid country'
    end
  end
  
  test 'it should remove a metropoli from the model when not found' do
    @user_class.metropoli_for_many  :cities
    new_user = @user_class.new
    new_user.cities << @mty
    assert_difference('new_user.cities.size', -1) do
      new_user.remove_city 'Monterrey'
    end
  end
  
  test 'it shouldnt remove a metropoli from the model when not found' do
    @user_class.metropoli_for_many  :states
    new_user = @user_class.new
    new_user.states << @mty.state
    assert_no_difference('new_user.states.size') do
      new_user.remove_state 'Invalid state'
    end
  end
  
  test 'it shouldnt add a model if its already there and metropoli specifies unique' do
    @user_class.metropoli_for_many  :countries, :unique => true
    new_user = @user_class.new
    new_user.countries << @mty.country
    assert_no_difference('new_user.states.size') do
      new_user.add_country 'Mexico'
    end
  end
  
  test 'it should be invalid if metropoli is required and not added' do
    @user_class.metropoli_for_many  :states, :required => true
    new_user = @user_class.new
    assert !new_user.valid?
    assert new_user.errors[:states].include?(Metropoli::Messages.error(:state, :not_enough))
  end
  
  test 'it should be invalid has a non reached min value' do
    @user_class.metropoli_for_many  :cities, :required => true, :min => 2
    new_user = @user_class.new
    new_user.cities << @mty
    assert !new_user.valid?
    assert new_user.errors[:cities].include?(Metropoli::Messages.error(:city, :not_enough))
  end
  
  test 'it should be invalid has an outreached max value' do
    @user_class.metropoli_for_many  :cities, :required => true, :max => 2
    new_user = @user_class.new
    new_user.cities << @mty << @mty << @mty
    assert !new_user.valid?
    assert new_user.errors[:cities].include?(Metropoli::Messages.error(:city, :too_many))
  end
  
  test 'it should valid if its within the limits' do
    @user_class.metropoli_for_many  :cities, :required => true, :max => 2
    new_user = @user_class.new
    new_user.cities << @mty << @mty
    new_user.valid?
    assert_equal  [], new_user.errors[:cities]
  end
  
end
