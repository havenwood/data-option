# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rake/testtask'
require 'rubocop/rake_task'

task default: %i[test rubocop]

Rake::TestTask.new do |test|
  test.pattern = 'test/**/*_test.rb'
  test.warning = false
end

RuboCop::RakeTask.new do |task|
  task.plugins << 'rubocop-minitest'
end
