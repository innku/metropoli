class MetropoliController < ActionController::Metal
  include Metropoli::ConfigurationHelper
  include ActionController::Rendering

  def cities
    render :text => city_class.autocomplete(params[:q]).limit(autocomplete_limit).to_json, :content_type => "application/json"
  end

  def states
    render :text => state_class.autocomplete(params[:q]).limit(autocomplete_limit).to_json, :content_type => "application/json"
  end

  def countries
    render :text => country_class.autocomplete(params[:q]).limit(autocomplete_limit).to_json, :content_type => "application/json"
  end
end
