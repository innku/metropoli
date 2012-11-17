require 'helper'

class TestConfiguration < ActionDispatch::IntegrationTest
  
  def setup
    Factory(:city)
    Factory(:state)
    Factory(:country)
  end
  
  test 'autocomplete limit' do
    30.times { setup }
    
    get "metropoli/cities.json"
    assert_equal ActiveSupport::JSON.decode(response.body).size, Metropoli.autocomplete_limit
    
    get "metropoli/states.json"
    assert_equal ActiveSupport::JSON.decode(response.body).size, Metropoli.autocomplete_limit
    
    get "metropoli/countries.json"
    assert_equal ActiveSupport::JSON.decode(response.body).size, Metropoli.autocomplete_limit
  end
  
  test 'autocomplete field configuration' do
    
    #Deletes the abbr from the response configured fields
    Metropoli.state_autocomplete_fields = 'name'
    Metropoli.country_autocomplete_fields = 'name'
    
    get "metropoli/states.json"
    assert_nil ActiveSupport::JSON.decode(response.body).first['state_model']['abbr']
    
    get "metropoli/countries.json"
    assert_nil ActiveSupport::JSON.decode(response.body).first['country_model']['abbr']
    
  end
  
  def teardown
    Metropoli::Helpers.return_to_defaults
  end
  
end
