module Metropoli
  require 'lib/my_gem/railtie' if defined?(Rails) && Rails::VERSION::MAJOR == 3
end