module Metropoli
  class StatesController < ApplicationController
    include ConfigurationHelper
    
    def index
      @states = eval(Metropoli.state_class).autocomplete(params[:q]).all
      respond_to do |format|
        format.json { render :json => @states, :root => :state, 
                                               :only => state_json_values,
                                               :methods => state_json_methods,
                                               :include => {:country => {:only => [:abbr, :name] } } }
      end
    end

  end
end