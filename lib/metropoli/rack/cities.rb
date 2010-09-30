module Metropoli
  class Cities
    extend ConfigurationHelper
    
    def self.call(env)
      @cities = eval(Metropoli.city_class).autocomplete(env["QUERY_STRING"].gsub('q=',''))
      @cities &= eval(Metropoli.city_class).limit(autocomplete_limit)
      [200, {}, ["[#{@cities.all.map(&:metropoli_json).join(',').to_s}]"]]
    end

  end
end