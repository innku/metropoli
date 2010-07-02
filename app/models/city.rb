class City < ActiveRecord::Base  
  belongs_to  :state
  
  def self.like(name)
    where("cities.name #{Metropoli::LIKE} ? OR cities.alt_name #{Metropoli::LIKE} ?",
          "%#{name}%","%#{name}%")
  end
  
end