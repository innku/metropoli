# encoding: UTF-8

require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

task :default => :test

desc 'Run Metropoli unit tests.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

desc 'Generate documentation for Metropoli'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "Metropoli #{version}"
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "metropoli"
    gem.summary = %Q{Rails engine used to relate your models to city database}
    gem.description = %Q{Rails engine used to relate your models to a city database}
    gem.email = "adrian@innku.com"
    gem.homepage = "http://github.com/adriancuadros/metropoli"
    gem.authors = ["Adrian Cuadros"]
    gem.add_development_dependency "rspec", "=1.3.0"
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end