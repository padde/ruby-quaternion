require 'rake'
require 'rake/testtask'

task :default => [:test_units]

desc "Run unit tests"
Rake::TestTask.new("test_units") { |t|
  t.pattern = 'test/test_*.rb'
  t.verbose = true
  t.warning = true
}