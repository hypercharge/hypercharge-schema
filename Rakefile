
require "bundler/gem_tasks"

require 'rake/testtask'

Rake::TestTask.new do |t|
  t.pattern = "test/ruby/*_spec.rb"
  t.ruby_opts << '-rubygems'
  t.libs << 'test/ruby'
  t.verbose = true
end


task :default => :test