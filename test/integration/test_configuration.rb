class TestConfiguration < ActionController::IntegrationTest
  
  def setup
    Factory(:city)
    Factory(:state)
    Factory(:country)
  end
  
  test 'autocomplete limit' do
    30.times { setup }
    
    get "/cities.json"
    assert_equal ActiveSupport::JSON.decode(response.body).size, Metropoli.autocomplete_limit
    
    get "/states.json"
    assert_equal ActiveSupport::JSON.decode(response.body).size, Metropoli.autocomplete_limit
    
    get "/countries.json"
    assert_equal ActiveSupport::JSON.decode(response.body).size, Metropoli.autocomplete_limit
  end
  
  test 'autocomplete field configuration' do
    
    #Deletes the abbr from the response configured fields
    Metropoli.state_autocomplete_fields = 'name'
    Metropoli.country_autocomplete_fields = 'name'
    
    get "/states.json"
    assert_nil ActiveSupport::JSON.decode(response.body).first['state']['abbr']
    
    get "/countries.json"
    assert_nil ActiveSupport::JSON.decode(response.body).first['country']['abbr']
    
  end
  
  def teardown
    Metropoli::Helpers.return_to_defaults
  end
  
end