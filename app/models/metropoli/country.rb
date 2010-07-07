module Metropoli
  class Country < ActiveRecord::Base
    has_many :states
    
    def self.autocomplete(string)
      self.like(string)
    end
    
    def self.like(name)
      where("countries.name #{Metropoli::LIKE} ? OR countries.abbr #{Metropoli::LIKE} ?",
            "%#{name}%","%#{name}%")
    end
    
    def to_s
      "#{self.name}"
    end
  
  end
end