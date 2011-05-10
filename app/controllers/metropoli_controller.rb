class MetropoliController < ActionController::Metal
  include Metropoli::ConfigurationHelper
  include ActionController::Rendering

  def cities
    render_autocomplete city_class
  end

  def states
    render_autocomplete state_class
  end

  def countries
    render_autocomplete country_class
  end

  private 
  def render_autocomplete klass
    render :text => klass.autocomplete(params[:q]).limit(autocomplete_limit).to_json, :content_type => "application/json"
  end
end
