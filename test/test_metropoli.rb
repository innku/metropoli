require 'helper'

class TestMetropoli < ActiveSupport::TestCase
  
  test 'model options can be configured through Metropoli' do
    swap Metropoli, :city_class => 'SomeClass', :city_autocomplete_fields => "some_fields" do
      assert_equal 'SomeClass', Metropoli.city_class
      assert_equal "some_fields", Metropoli.city_autocomplete_fields
    end
  end

  test 'setup block yields self' do
    Metropoli.setup do |config|
      assert_equal Metropoli, config
    end
  end
  
  test 'can extend metropoli classes' do
    SomeClass = Class.new(ActiveRecord::Base)
    SomeClass.table_name = 'users'
    
    Metropoli::Helpers.set_custom_classes
    
    SomeClass.metropoli_for :city
    SomeClass.metropoli_for :state
    SomeClass.metropoli_for :country
    
    assert SomeClass.new.build_city.class.to_s, 'City'
    assert SomeClass.new.build_state.class.to_s, 'State'
    assert SomeClass.new.build_country.class.to_s, 'Country'
  end
  
  def teardown
    Metropoli::Helpers.return_to_defaults
  end
  
end
