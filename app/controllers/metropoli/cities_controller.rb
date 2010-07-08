module Metropoli
  class CitiesController < ApplicationController

    def index
      @cities = eval(Metropoli.city_class).like(params[:q]).all
      respond_to do |format|
        format.json { render :json => @cities }
      end
    end

  end
end