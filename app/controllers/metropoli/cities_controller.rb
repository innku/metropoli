module Metropoli
  class CitiesController < ApplicationController
    include ConfigurationHelper
    
    def index
      @cities = eval(Metropoli.city_class).autocomplete(params[:q]).limit(autocomplete_limit).all
      respond_to do |format|
        format.json { render :json => @cities, :root => :city, 
                                               :only => city_json_values,
                                               :methods => city_json_methods,
                                               :include => {:state => {:only => [:abbr, :name],
                                                                       :include => {:country => {:only => [:abbr]}}} } }
      end
    end

  end
end