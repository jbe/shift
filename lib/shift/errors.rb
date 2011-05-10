

module Shift

  # Shift base error, from which other errors inherit.
  #
  class Error < StandardError; end

  # Raised when the environment needed to perform a given
  # action is not available. Typically, you will need to
  # install another gem or some library/software.
  #
  class DependencyError < Error; end

  # Raised when you try to read a file for which there are
  # no mappings, without specifying its type.
  #
  class UnknownFormatError < Error; end

  # Raised when encountering invalid mappings, like
  # when there is a cycle in the map.
  #
  class MappingError < Error; end

end
