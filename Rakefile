# encoding: UTF-8

require 'bundler'
Bundler::GemHelper.install_tasks

require 'rake/testtask'
require 'rake'
require 'rake/testtask'

desc 'Run Metropoli unit tests.'
Rake::TestTask.new(:test) do |test|
  test.libs << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

task :default => :test
