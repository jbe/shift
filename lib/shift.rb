

#  SHIFT
#  Compiler and compressor interface framework
#  (c) 2011 Jostein Berre Eliassen - MIT licence


require 'lazy_load'


module Shift

  VERSION = '0.4.0'

  require 'shift/errors'
  require 'shift/data'
  


  class << self

    def [](path)
      path = '.' + path.to_s if path.is_a?(Symbol)
      path = File.basename(path.to_s).downcase

      until path.empty?
        return Data.const_get(Data::MAP[path]) if Data::MAP[path]
        path.sub!(/^[^.]*\.?/, '')
      end
      Data::BasicFile
    end
  
    def new(data='', path=nil)
      self[path].new(data, path)
    end

    # Read a file, returning a Shift string.
    # @param [String] path the file to read from.
    # @param [String] new_path treat the shift string as if it came
    #   from this path. Can be used to override file type behavior.
    #
    # (see Shift.new)
    #
    def read(path, alt_path=nil)
      new(File.read(path), alt_path || path)
    end

    # Read and concatenate several files.
    # (see Shift.read)
    #
    # TODO: glob
    #
    def concat(*args)
      self[args.first].concat(*args)
    end
    alias :cat :concat

  end
end

# (see Shift.new)
#
def Shift(*args)
  Shift.new(*args)
end


