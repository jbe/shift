

module Shift

  # Returns the input unaltered. The purpose is mainly to inherit
  # from this when defining other, more useful compilers.
  #
  class Identity

    # One-liner on what the user must have/do to make it available.
    # Used in DependencyError.
    INSTRUCTIONS = 'Google it :)'

    # Wether the requirements are met in the current environment.
    # Typically checks if the required gems and/or command line
    # stuff is available.
    #
    def self.available?
      true
    end

    # A default instance without user given options.
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
      process(File.read(path))
    end

    # Read and process files, writing to new files.
    #
    # @param [Hash] hsh A hash where the keys and values are
    #   strings representing file paths, as in
    #   `'source.js' => 'source.min.js'`
    #
    def readwrite(hsh)
      hsh.each do |from, to|
        File.open(to, 'w') do |file|
          file.write(read(from))
        end
      end
    end

    # Process strings, writing to new files.
    #
    # @param [Hash] hsh A hash where the keys are strings
    #   to be processed, and the values are file path strings,
    #   where the results are to be saved, as in
    #   `'some frog pog with a hat' => 'myfile.frog'`.
    #
    def write(hsh)
      hsh.each do |str, to|
        File.open(to, 'w') do |file|
          file.write(process(str))
        end
      end
    end

  end
end
