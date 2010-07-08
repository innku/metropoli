require 'metropoli'
require 'rails'
require 'metropoli/routes'

module Metropoli
  class Engine < Rails::Engine
    config.before_eager_load { |app| app.reload_routes! }
  end
end