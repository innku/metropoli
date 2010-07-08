module ActionDispatch::Routing
  class Mapper
    
    def metropoli_for(*resources)
      resources.map!(&:to_sym)
      resources.map{|r| resource_route(r) }
    end
    
    protected
    
    def resource_route(resource_name)
      resource resource_name, :only => [:index], :controller => "metropoli/#{resource_name.pluralize}"
    end
    
  end
end