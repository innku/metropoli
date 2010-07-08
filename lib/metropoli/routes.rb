module ActionDispatch::Routing
  class Mapper
    def metropoli_for(*resources)
      resources.map{|resource_name| resource_route(resource_name) }
    end
    
    protected
    
    def resource_route(resource_name)
      self.resources resource_name, :only => [:index], :controller => "metropoli/#{resource_name.to_s.pluralize}"
    end
    
  end
end