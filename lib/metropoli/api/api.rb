require 'sinatra'

module Metropoli
  class Api < Sinatra::Base
    include ConfigurationHelper
  
    get '/cities.json' do
      city_class.autocomplete(params[:q]).limit(autocomplete_limit).to_json
    end

    get '/states.json' do
      state_class.autocomplete(params[:q]).limit(autocomplete_limit).to_json
    end

    get '/countries.json' do
      country_class.autocomplete(params[:q]).limit(autocomplete_limit).to_json
    end
  end
end
