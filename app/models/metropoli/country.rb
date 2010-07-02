class Metropoli::Country < ActiveRecord::Base
  has_many :states
  
  def self.like(name)
    where("countries.name #{Metropoli::LIKE} ? OR countries.abbr #{Metropoli::LIKE} ?",
          "%#{name}%","%#{name}%")
  end
  
end