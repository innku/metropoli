class City < ActiveRecord::Base  
  belongs_to  :state
  
  def find_for_autocomplete(query)
    city, state, country = params[:q].split(',').map(&:strip)
    results = City.includes(:state => :country)
    results = results.city_like(city)
  end
  
  def self.city_like(city)
    where("cities.name #{like_statement} or cities.alt_name #{like_statement} ?", "%#{city}%","%#{city}%")
  end
  
  protected
  
  def like_statement
    if (City.connection.adapter_name.downcase.include?('postgres'))
      return 'ILIKE'
    else
      return 'LIKE'
    end
  end
  
end