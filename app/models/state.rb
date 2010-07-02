class State < ActiveRecord::Base
  belongs_to :country
  has_many :cities
  
  def self.like(name)
    where("states.name #{self.like_statement} ? OR states.abbr #{self.like_statement} ? OR 
           states.abbr2 #{self.like_statement} ? OR states.abbr3 #{self.like_statement} ?",
          "%#{name}%","%#{name}%","%#{name}%","%#{name}%")
  end
  
  protected
  
  def self.like_statement
    if (City.connection.adapter_name.downcase.include?('postgres'))
      return 'ILIKE'
    else
      return 'LIKE'
    end
  end
  
end
