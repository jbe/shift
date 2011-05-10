

#  SHIFT
#
#  State and logic-less compiler and compressor interface
#
#  (c) 2011 Jostein Berre Eliassen - MIT licence


module Shift

  VERSION = '0.3.0'

  require 'shift/errors'
  require 'shift/mapper'
  require 'shift/mappings'


  # Read and process a file with the mapped component.
  #
  # @see Shift.[]
  #
  # (see Identity#read)
  #
  def self.read(path, action=:default, type=nil)
    self[type || path, action].new.read(path)
  end

end

