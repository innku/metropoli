module Metropoli
  class CountriesController < ApplicationController

    def index
      @countries = eval(Metropoli.country_class).like(params[:q]).all
      respond_to do |format|
        format.json { render :json => @countries }
      end
    end

  end
end