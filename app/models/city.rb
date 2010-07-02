class City < ActiveRecord::Base  
  belongs_to  :state
  
  def self.like(name)
    where("cities.name #{LIKE} ? OR cities.alt_name #{LIKE} ?",
          "%#{name}%","%#{name}%")
  end
  
end