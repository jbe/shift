

#  SHIFT
#
#  State and logic-less compiler and compressor interface
#
#  (c) 2011 Jostein Berre Eliassen - MIT licence


module Shift

  VERSION = '0.0.1'

  require 'shift/errors'
  require 'shift/mappings'


  # components

  autoload :Identity,         'shift/c/identity'
  autoload :UglifyJS,         'shift/c/uglify_js'
  autoload :ClosureCompiler,  'shift/c/closure_compiler'
  autoload :YUICompressor,    'shift/c/yui_compressor'
  autoload :CoffeeScript,     'shift/c/coffee_script'
  autoload :Sass,             'shift/c/sass'


  # Read and process a file with the mapped component.
  #
  # @see Shift.[]
  #
  # (see Identity#read)
  #
  def self.read(path, opts={})
    self[path].new(opts).read
  end

  # Read and process a file with the mapped handler, then
  # write it somewhere.
  #
  # @see Shift.[]
  #
  # (see Identity#readwrite)
  #
  def self.readwrite(hsh)
    hsh.each do |from, to|
      self[from].default.readwrite(from => to)
    end
  end

  # Get the preferred available class mapped to match the
  # given filename or extension.
  #
  # @raise [UnknownFormatError] when none of the mappings match.
  #
  # (see Shift.best_available_mapping_for)
  #
  def self.[](file, opts={})
    pattern = file.to_s.downcase
    until pattern.empty?
      if MAPPINGS[pattern]
        return best_available_mapping_for(pattern).new(opts)
      end
      pattern = File.basename(pattern)
      pattern.sub!(/^[^.]*\.?/, '')
    end
    raise UnknownFormatError, "no mapping matches #{file}"
  end

end

