module Metropoli
  class State < ActiveRecord::Base
    belongs_to  :country
    has_many    :cities
  
    def self.like(name)
      where("states.name #{Metropoli::LIKE} ? OR states.abbr #{Metropoli::LIKE} ?",
            "%#{name}%","%#{name}%",)
    end

  end
end
