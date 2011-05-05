

#  SHIFT
#
#  State and logic-less compiler and compressor interface
#
#  (c) 2011 Jostein Berre Eliassen - MIT licence


module Shift

  VERSION = '0.0.1'

  require 'shift/errors'

  require 'shift/identity'

  require 'shift/mappings'

  # Read and process a file with the mapped handler
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
  # @raise [UnknownFormatError] when none of the mapped
  #   implementations are available.
  #
  # @return [Class] The preferred available class associated
  #   with the file or extension, or nil when no mapping matches.
  #
  def self.[](file, opts={})
    pattern = file.to_s.downcase
    until pattern.empty?
      if MAPPINGS[pattern]
        return best_available(MAPPINGS[pattern]).new(opts)
      end
      pattern = File.basename(pattern)
      pattern.sub!(/^[^.]*\.?/, '')
    end
    raise UnknownFormatError, "no mapping matches #{file}"
  end

  def self.best_available(cls_ary)
    # TODO
  end

end

