

module Shift

  # Returns the input unaltered. The purpose is mainly to inherit
  # from this when defining other, more useful compilers.
  #
  class Identity

    # Mixed into the resulting strings to make them easy to save.
    #
    module StringExtension

      # Write the string to a sepcified path.
      #
      def write(path)
        File.open(path, 'w') do |file|
          file.write(self)
        end
        self
      end
    end


    # One-liner on what the user must have/do to make it available.
    # Used in DependencyError.
    #
    INSTRUCTIONS = 'Google it :)'

    # Wether the requirements are met in the current environment.
    # Typically checks if the required gems and/or command line
    # stuff is available.
    #
    def self.available?
      true
    end

    # A default instance without options.
    #
    def self.default
      @default ||= new
    end

    # Create a new instance. Ignores the given options.
    #
    def initialize(opts); end

    # Process the supplied string, returning the resulting `String`.
    #
    def process(str)
      str.dup
    end
    alias :compress   :process
    alias :compile    :process
    alias :transform  :process

    # Read and process a file.
    #
    # @raise [DependencyError] when none of the mapped
    #   implementations are available.
    #
    # @return [String] The processed `String`
    #
    def read(path)
      process(File.read(path)).extend(StringExtension)
    end

  end
end
