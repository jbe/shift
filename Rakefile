
task :test do
  $LOAD_PATH.unshift './lib'
  require 'shift'
  require 'minitest/autorun'
  begin; require 'turn'; rescue LoadError; end
  Dir.glob("test/**/*_test.rb").each { |test| require "./#{test}" }
end

task :shell do
  system 'pry -I lib -r shift --trace'
end

task :default => :test



