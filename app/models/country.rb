class Country < ActiveRecord::Base
  has_many :states
  
  def self.country_like(country)
    where("countries.name #{self.like_statement} ? OR countries.abbr #{self.like_statement} ?",
          "%#{country}%","%#{country}%")
  end
  
end