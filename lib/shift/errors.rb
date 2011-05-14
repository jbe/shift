

module Shift

  # Shift base error, from which other errors inherit.
  #
  class Error < StandardError; end

  # Raised when the environment needed to perform a given
  # action is not available. Typically, you will need to
  # install another gem or some library/software.
  #
  class DependencyError < Error; end

  class LookupError        < Error; end
  class UnknownFormatError < LookupError; end
  class UnknownActionError < LookupError; end

  # Raised when encountering invalid mappings, like
  # when there is a cycle in the map.
  #
  class MappingError < Error; end

end
