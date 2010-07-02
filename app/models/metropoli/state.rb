module Metropoli
  class State < ActiveRecord::Base
    belongs_to  :country
    has_many    :cities
  
    def self.like(name)
      where("states.name #{Metropoli::LIKE} ? OR states.abbr #{Metropoli::LIKE} ? OR 
             states.abbr2 #{Metropoli::LIKE} ? OR states.abbr3 #{Metropoli::LIKE} ?",
            "%#{name}%","%#{name}%","%#{name}%","%#{name}%")
    end

  end
end
