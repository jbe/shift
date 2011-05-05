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

  s.summary       = 'Shift is a generic interface to different compilers, compressors, etc.'
  s.description   = 'Shift is a generic interface to different compilers, compressors, etc. What the Tilt gem does for template languages, Shift does for compilers and compressors.'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- spec/*`.split("\n")
  s.require_path  = 'lib'
  s.bindir        = 'bin'
end
