module ActionDispatch::Routing
  class Mapper
    def metropoli_for(*resources)
      resources.map{|resource_name| resource_route(resource_name.to_s) }
    end
    
    protected
    
    def resource_route(resource_name)
      self.match "#{resource_name}.json" => eval("Metropoli::#{resource_name.titleize}")
    end
    
  end
end