require 'sinatra'

module Metropoli
  class Api < Sinatra::Base
    include ConfigurationHelper
  
    get '/metropoli/cities.json' do
      @cities = city_class.autocomplete(params[:q])
      @cities = @cities.merge(city_class.limit(autocomplete_limit))
      @cities.to_json
    end
  
    get '/metropoli/states.json' do 
      @states = state_class.autocomplete(params[:q])
      @states = @states.merge(state_class.limit(autocomplete_limit))
      @states.to_json
    end
  
    get '/metropoli/countries.json' do
      @countries = country_class.autocomplete(params[:q])
      @countries = @countries.merge(country_class.limit(autocomplete_limit))
      @countries.to_json
    end
    
    get '/metropoli/cities_and_countries.json' do
      @countries = country_class.autocomplete(params[:q])
      @countries = @countries.merge(country_class.limit(autocomplete_limit))

      @cities = city_class.autocomplete(params[:q])
      @cities = @cities.merge(city_class.limit(autocomplete_limit))

      {
        'countries' => @countries,
        'cities' => @cities
      }.to_json
    end
  end
end
