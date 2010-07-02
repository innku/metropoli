class Metropoli::City < ActiveRecord::Base  
  belongs_to  :state
  
  def self.find_for_autocomplete(string)
    city, state, country = string.split(',').map(&:strip)
    unless city.blank?
      results = country.nil? ? City.includes(:state) : City.includes(:state => :country)
      results = results.like(city)
      results &= State.like(state) unless state.blank?
      results &= Country.like(country) unless country.blank?
    end
    results
  end
  
  def self.like(name)
    where("cities.name #{Metropoli::LIKE} ? OR cities.alt_name #{Metropoli::LIKE} ?",
          "%#{name}%","%#{name}%")
  end
  
end