require 'sinatra'

module Metropoli
  class Api < Sinatra::Base
    include ConfigurationHelper
  
    helpers do
      def autocomplete(model, search_param)
        model.autocomplete(search_param).limit(autocomplete_limit)
      end
    end

    get '/metropoli/cities.json' do
      autocomplete(city_class, params[:q]).to_json
    end
  
    get '/metropoli/states.json' do 
      autocomplete(state_class, params[:q]).to_json
    end
  
    get '/metropoli/countries.json' do
      autocomplete(country_class, params[:q]).to_json
    end
    
    get '/metropoli/cities_and_countries.json' do
      countries = autocomplete(country_class, params[:q])
      cities = autocomplete(city_class, params[:q])

      { 'countries' => countries, 'cities' => cities }.to_json
    end
  end
end
