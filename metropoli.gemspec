# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{metropoli}
  s.version = "0.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Adrian Cuadros"]
  s.date = %q{2010-10-22}
  s.description = %q{With this engine you can generate a flexible and unobstrusive city database engine that you can relate to your rails 3 models}
  s.email = %q{adrian@innku.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.textile"
  ]
  s.files = [
    ".bundle/config",
     ".document",
     ".gitignore",
     "Gemfile",
     "Gemfile.lock",
     "LICENSE",
     "README.textile",
     "Rakefile",
     "VERSION",
     "app/models/metropoli/city_model.rb",
     "app/models/metropoli/country_model.rb",
     "app/models/metropoli/state_model.rb",
     "config/initializers/set_database_like.rb",
     "lib/generators/metropoli/install/install_generator.rb",
     "lib/generators/metropoli/install/templates/README",
     "lib/generators/metropoli/install/templates/csv/cities.csv",
     "lib/generators/metropoli/install/templates/csv/countries.csv",
     "lib/generators/metropoli/install/templates/csv/states.csv",
     "lib/generators/metropoli/install/templates/initializers/metropoli.rb",
     "lib/generators/metropoli/install/templates/javascripts/metropoli.jquery.ui.js",
     "lib/generators/metropoli/install/templates/locales/en.yml",
     "lib/generators/metropoli/install/templates/migrate/create_metropoli_cities.rb",
     "lib/generators/metropoli/install/templates/migrate/create_metropoli_countries.rb",
     "lib/generators/metropoli/install/templates/migrate/create_metropoli_states.rb",
     "lib/generators/metropoli/metropoli/metropoli_generator.rb",
     "lib/generators/metropoli/metropoli/templates/README",
     "lib/generators/metropoli/metropoli/templates/migrate/belongs_to.rb",
     "lib/generators/metropoli/metropoli/templates/migrate/has_and_belongs_to_many.rb",
     "lib/generators/metropoli_generator.rb",
     "lib/metropoli.rb",
     "lib/metropoli/api/api.rb",
     "lib/metropoli/api/cities.rb",
     "lib/metropoli/api/countries.rb",
     "lib/metropoli/api/states.rb",
     "lib/metropoli/associations.rb",
     "lib/metropoli/configuration_helper.rb",
     "lib/metropoli/engine.rb",
     "lib/metropoli/routes.rb",
     "lib/metropoli/seed_helper.rb",
     "lib/metropoli/statement_helper.rb",
     "lib/tasks/metropoli.rake",
     "metropoli.gemspec",
     "test/associations/test_metropoli_for.rb",
     "test/associations/test_metropoli_for_many.rb",
     "test/factories.rb",
     "test/helper.rb",
     "test/integration/test_configuration.rb",
     "test/models/test_city.rb",
     "test/models/test_country.rb",
     "test/models/test_state.rb",
     "test/support/assertions.rb",
     "test/support/helpers.rb",
     "test/support/metropoli_helpers.rb",
     "test/test_app/.gitignore",
     "test/test_app/Gemfile",
     "test/test_app/Gemfile.lock",
     "test/test_app/README",
     "test/test_app/Rakefile",
     "test/test_app/app/controllers/application_controller.rb",
     "test/test_app/app/helpers/application_helper.rb",
     "test/test_app/app/models/city.rb",
     "test/test_app/app/models/country.rb",
     "test/test_app/app/models/state.rb",
     "test/test_app/app/models/user.rb",
     "test/test_app/app/views/layouts/application.html.erb",
     "test/test_app/config.ru",
     "test/test_app/config/application.rb",
     "test/test_app/config/boot.rb",
     "test/test_app/config/database.yml",
     "test/test_app/config/environment.rb",
     "test/test_app/config/environments/development.rb",
     "test/test_app/config/environments/production.rb",
     "test/test_app/config/environments/test.rb",
     "test/test_app/config/initializers/backtrace_silencers.rb",
     "test/test_app/config/initializers/inflections.rb",
     "test/test_app/config/initializers/metropoli.rb",
     "test/test_app/config/initializers/mime_types.rb",
     "test/test_app/config/initializers/secret_token.rb",
     "test/test_app/config/initializers/session_store.rb",
     "test/test_app/config/locales/en.yml",
     "test/test_app/config/locales/metropoli.en.yml",
     "test/test_app/config/routes.rb",
     "test/test_app/db/csv/cities.csv",
     "test/test_app/db/csv/countries.csv",
     "test/test_app/db/csv/states.csv",
     "test/test_app/db/migrate/20100712170347_create_metropoli_countries.rb",
     "test/test_app/db/migrate/20100712170348_create_metropoli_states.rb",
     "test/test_app/db/migrate/20100712170349_create_metropoli_cities.rb",
     "test/test_app/db/migrate/20100712202858_create_users.rb",
     "test/test_app/db/migrate/20100712203012_add_city_to_users.rb",
     "test/test_app/db/migrate/20100712220159_add_cities_to_users.rb",
     "test/test_app/db/migrate/20100712220205_add_states_to_users.rb",
     "test/test_app/db/migrate/20100712220212_add_countries_to_users.rb",
     "test/test_app/db/schema.rb",
     "test/test_app/db/seeds.rb",
     "test/test_app/doc/README_FOR_APP",
     "test/test_app/lib/tasks/.gitkeep",
     "test/test_app/public/404.html",
     "test/test_app/public/422.html",
     "test/test_app/public/500.html",
     "test/test_app/public/favicon.ico",
     "test/test_app/public/images/rails.png",
     "test/test_app/public/index.html",
     "test/test_app/public/javascripts/application.js",
     "test/test_app/public/javascripts/controls.js",
     "test/test_app/public/javascripts/dragdrop.js",
     "test/test_app/public/javascripts/effects.js",
     "test/test_app/public/javascripts/metropoli.jquery.ui.js",
     "test/test_app/public/javascripts/prototype.js",
     "test/test_app/public/javascripts/rails.js",
     "test/test_app/public/robots.txt",
     "test/test_app/public/stylesheets/.gitkeep",
     "test/test_app/script/rails",
     "test/test_app/test/performance/browsing_test.rb",
     "test/test_app/test/test_helper.rb",
     "test/test_app/vendor/plugins/.gitkeep",
     "test/test_metropoli.rb"
  ]
  s.homepage = %q{http://github.com/adriancuadros/metropoli}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{City database engine for rails 3}
  s.test_files = [
    "test/associations/test_metropoli_for.rb",
     "test/associations/test_metropoli_for_many.rb",
     "test/factories.rb",
     "test/helper.rb",
     "test/integration/test_configuration.rb",
     "test/models/test_city.rb",
     "test/models/test_country.rb",
     "test/models/test_state.rb",
     "test/support/assertions.rb",
     "test/support/helpers.rb",
     "test/support/metropoli_helpers.rb",
     "test/test_app/app/controllers/application_controller.rb",
     "test/test_app/app/helpers/application_helper.rb",
     "test/test_app/app/models/city.rb",
     "test/test_app/app/models/country.rb",
     "test/test_app/app/models/state.rb",
     "test/test_app/app/models/user.rb",
     "test/test_app/config/application.rb",
     "test/test_app/config/boot.rb",
     "test/test_app/config/environment.rb",
     "test/test_app/config/environments/development.rb",
     "test/test_app/config/environments/production.rb",
     "test/test_app/config/environments/test.rb",
     "test/test_app/config/initializers/backtrace_silencers.rb",
     "test/test_app/config/initializers/inflections.rb",
     "test/test_app/config/initializers/metropoli.rb",
     "test/test_app/config/initializers/mime_types.rb",
     "test/test_app/config/initializers/secret_token.rb",
     "test/test_app/config/initializers/session_store.rb",
     "test/test_app/config/routes.rb",
     "test/test_app/db/migrate/20100712170347_create_metropoli_countries.rb",
     "test/test_app/db/migrate/20100712170348_create_metropoli_states.rb",
     "test/test_app/db/migrate/20100712170349_create_metropoli_cities.rb",
     "test/test_app/db/migrate/20100712202858_create_users.rb",
     "test/test_app/db/migrate/20100712203012_add_city_to_users.rb",
     "test/test_app/db/migrate/20100712220159_add_cities_to_users.rb",
     "test/test_app/db/migrate/20100712220205_add_states_to_users.rb",
     "test/test_app/db/migrate/20100712220212_add_countries_to_users.rb",
     "test/test_app/db/schema.rb",
     "test/test_app/db/seeds.rb",
     "test/test_app/test/performance/browsing_test.rb",
     "test/test_app/test/test_helper.rb",
     "test/test_metropoli.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, ["= 1.3.0"])
      s.add_runtime_dependency(%q<fastercsv>, ["~> 1.5.3"])
      s.add_runtime_dependency(%q<sinatra>, [">= 1.0"])
      s.add_runtime_dependency(%q<json>, ["~> 1.4.6"])
    else
      s.add_dependency(%q<rspec>, ["= 1.3.0"])
      s.add_dependency(%q<fastercsv>, ["~> 1.5.3"])
      s.add_dependency(%q<sinatra>, [">= 1.0"])
      s.add_dependency(%q<json>, ["~> 1.4.6"])
    end
  else
    s.add_dependency(%q<rspec>, ["= 1.3.0"])
    s.add_dependency(%q<fastercsv>, ["~> 1.5.3"])
    s.add_dependency(%q<sinatra>, [">= 1.0"])
    s.add_dependency(%q<json>, ["~> 1.4.6"])
  end
end

