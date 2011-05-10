module ActionDispatch::Routing
  class Mapper
    def metropoli_for(*resources)
      resources.map{|resource_name| resource_route(resource_name.to_s) }
    end
    
    protected
    def resource_route(resource_name)
      self.match "auto-complete/#{resource_name}.json" => "metropoli##{resource_name}"
    end
  end
end
