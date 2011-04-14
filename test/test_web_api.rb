require 'helper'

class TestConfiguration < ActionController::IntegrationTest
  context 'cities' do
    should 'return json with determined record count' do
      get "/cities.json"
      assert_equal Metropoli.autocomplete_limit, ActiveSupport::JSON.decode(response.body).size
    end

    should 'filter by query' do
      get '/cities.json?q=obregon'
      assert_equal 9, ActiveSupport::JSON.decode(response.body).size
    end

    should 'return defined json representation' do
      get '/cities.json'
      cities = ActiveSupport::JSON.decode(response.body)
      assert_equal %w(id to_s), cities.first['city'].keys.sort
    end
  end

  context 'states' do
    should 'return json with determined record count' do
      get "/states.json"
      assert_equal Metropoli.autocomplete_limit, ActiveSupport::JSON.decode(response.body).size
    end

    should 'filter by query' do
      get '/states.json?q=mexico'
      assert_equal 2, ActiveSupport::JSON.decode(response.body).size
    end

    should 'return defined json representation' do
      get '/states.json'
      states = ActiveSupport::JSON.decode(response.body)
      assert_equal %w(id to_s), states.first['state'].keys.sort
    end
  end

  context 'countries' do
    should 'return json with determined record count' do
      get "/countries.json"
      assert_equal 2, ActiveSupport::JSON.decode(response.body).size
    end

    should 'filter by query' do
      get '/countries.json?q=mexico'
      assert_equal 1, ActiveSupport::JSON.decode(response.body).size
    end

    should 'return defined json representation' do
      get '/countries.json'
      countries = ActiveSupport::JSON.decode(response.body)
      assert_equal %w(id to_s), countries.first['country'].keys.sort
    end
  end
end
