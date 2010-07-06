module Metropoli
  if defined?(Rails) && Rails::VERSION::MAJOR == 3
    require 'metropoli/engine' 
    require 'metropoli/associations'
  end
end