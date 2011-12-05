module ActionDispatch::Routing
  class Mapper
    def metropoli_for(*resources)
      resources.map{|resource_name| resource_route(resource_name.to_s) }
    end
    
    protected
    
    def resource_route(resource_name)
      self.match "/metropoli/#{resource_name}.json" => Metropoli::Api
    end
    
  end
end