module Metropoli
  class CountriesController < ApplicationController

    def index
      @countries = Country.like(params[:q]).all
      respond_to do |format|
        format.json { render :json => @countries }
      end
    end

  end
end