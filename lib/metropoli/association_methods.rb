module Metropoli
  def self.included(base)
    base.send :extend, ClassMethods
  end
  
  module ClassMethods
    
    def belongs_to_metropoli
      self.belongs_to :city, :class_name => 'Metropoli::City'
      send :include, InstanceMethods
    end
    
  end
  
  module InstanceMethods
      
  end
  
end

ActiveRecord::Base.send :include, Metropoli