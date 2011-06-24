$:.push File.expand_path('../lib', __FILE__)
require 'shift'

Gem::Specification.new do |s|

  s.name      = 'shift'

  s.author    = 'Jostein Berre Eliassen'
  s.email     = 'josteinpost@gmail.com'
  s.homepage  = "http://github.com/jbe/shift"
  s.license   = "MIT"

  s.version   = Shift::VERSION
  s.platform  = Gem::Platform::RUBY

  s.summary       = 'Compiler and transformer interface framework'
  s.description   = 'Shift is a generic interface to different compilers, compressors, and so on. You can use it to build chains, like Shift.read("cup.coffee").compile.minify.move("./public/js/").write'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- spec/*`.split("\n")
  s.require_path  = 'lib'
  s.bindir        = 'bin'
  s.executables   = ['shifter']

  s.add_dependency 'lazy_load', '>= 0.1.3'
end
