module Metropoli
  class States
    extend ConfigurationHelper
    
    def self.call(env)
      @states = eval(Metropoli.state_class).autocomplete(env["QUERY_STRING"].gsub('q=',''))
      @states &= eval(Metropoli.state_class).limit(autocomplete_limit)
      [200, {}, ["[#{@states.all.map(&:metropoli_json).join(',').to_s}]"]]
    end

  end
end