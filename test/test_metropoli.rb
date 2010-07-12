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
  
end
