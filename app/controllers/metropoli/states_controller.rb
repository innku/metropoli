module Metropoli
  class StatesController < ApplicationController

    def index
      @states = eval(Metropoli.state_class).like(params[:q]).all
      respond_to do |format|
        format.json { render :json => @states }
      end
    end

  end
end