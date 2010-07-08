module Metropoli
  class CitiesController < ApplicationController

    def index
      @cities = City.like(params[:q]).all
      respond_to do |format|
        format.json { render :json => @cities }
      end
    end

  end
end