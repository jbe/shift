
task :test do
  $LOAD_PATH.unshift './lib'
  require 'shift'
  require 'minitest/autorun'
  begin; require 'turn'; rescue LoadError; end
  Dir.glob("test/**/*_test.rb").each { |test| require "./#{test}" }
end

task :shell do
  system 'pry -I lib -r shift'
end

task :default => :test


begin
  require 'grancher/task'
  require 'yard'
  
  YARD::Rake::YardocTask.new

  Grancher::Task.new do |g|
    g.branch = 'gh-pages'
    g.push_to = 'origin'
    g.message = 'docs -> gh-pages'
    g.directory 'docs'
  end

  task :publish => :yard

rescue LoadError; end

