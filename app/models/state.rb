class State < ActiveRecord::Base
  belongs_to :country
  has_many :cities
  
  def self.state_like(state)
    where("states.name #{self.like_statement} ? OR states.abbr #{self.like_statement} ? OR 
           states.abbr2 #{self.like_statement} ? OR states.abbrs3 #{self.like_statement} ?",
          "%#{state}%","%#{state}%","%#{state}%","%#{state}%")
  end
  
end
