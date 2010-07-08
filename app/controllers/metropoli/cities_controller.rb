class Metropoli::CitiesController < ApplicationController

  def index
    @cities = City.like(params[:q])
    render :json => @cities
  end

end