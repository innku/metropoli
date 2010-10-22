module Metropoli
  class Countries
    extend ConfigurationHelper
    
    def self.call(env)
      @countries = eval(Metropoli.country_class).autocomplete(env["QUERY_STRING"].gsub('q=',''))
      @countries &= eval(Metropoli.country_class).limit(autocomplete_limit)
      [200, {}, ["[#{@countries.all.map(&:metropoli_json).join(',').to_s}]"]]
    end

  end
end