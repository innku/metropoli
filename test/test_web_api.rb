require 'helper'

class TestWebApi < ActionDispatch::IntegrationTest
  context 'cities' do
    should 'return json with determined record count' do
      get "/metropoli/cities.json"
      assert_equal 8, ActiveSupport::JSON.decode(response.body).size
    end

    should 'filter by query' do
      get '/metropoli/cities.json?q=cochabamba'
      assert_equal 1, ActiveSupport::JSON.decode(response.body).size
    end

    should 'return defined json representation' do
      get '/metropoli/cities.json'
      cities = ActiveSupport::JSON.decode(response.body)
      assert_equal %w(id to_s), cities.first['city_model'].keys.sort
    end
  end

  context 'states' do
    should 'return json with determined record count' do
      get "/metropoli/states.json"
      assert_equal 4, ActiveSupport::JSON.decode(response.body).size
    end

    should 'filter by query' do
      get '/metropoli/states.json?q=cochabamba'
      assert_equal 1, ActiveSupport::JSON.decode(response.body).size
    end

    should 'return defined json representation' do
      get '/metropoli/states.json'
      states = ActiveSupport::JSON.decode(response.body)
      assert_equal %w(id to_s), states.first['state_model'].keys.sort
    end
  end

  context 'countries' do
    should 'return json with determined record count' do
      get "/metropoli/countries.json"
      assert_equal 2, ActiveSupport::JSON.decode(response.body).size
    end

    should 'filter by query' do
      get '/metropoli/countries.json?q=mexico'
      assert_equal 1, ActiveSupport::JSON.decode(response.body).size
    end

    should 'return defined json representation' do
      get '/metropoli/countries.json'
      countries = ActiveSupport::JSON.decode(response.body)
      assert_equal %w(id to_s), countries.first['country_model'].keys.sort
    end
  end

  context 'cities_and_countries' do
    should 'return json with determined record count' do
      get "/metropoli/cities_and_countries.json"
      results = ActiveSupport::JSON.decode(response.body)
      assert_equal 2, results['countries'].size
      assert_equal 8, results['cities'].size
    end

    should 'filter by query' do
      get '/metropoli/cities_and_countries.json?q=mexico'
      results = ActiveSupport::JSON.decode(response.body)
      assert_equal 1, results['countries'].size
      assert_equal 0, results['cities'].size
    end

    should 'return defined json representation' do
      get '/metropoli/cities_and_countries.json'
      results = ActiveSupport::JSON.decode(response.body)
      assert_equal %w(id to_s), results['countries'].first['country_model'].keys.sort
      assert_equal %w(id to_s), results['cities'].first['city_model'].keys.sort
    end
  end
end
