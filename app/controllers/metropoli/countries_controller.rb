module Metropoli
  class CountriesController < ApplicationController
    include ConfigurationHelper
    
    def index
      @countries = eval(Metropoli.country_class).autocomplete(params[:q]).limit(autocomplete_limit).all
      respond_to do |format|
        format.json { render :json => @countries, :root => :country, 
                                                  :only => country_json_values,
                                                  :methods => country_json_methods }
      end
    end

  end
end