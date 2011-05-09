

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
      gem_dependencies.all? {|d| Gem.available?(d) }
    end

    # A list of Rubygems needed for the component to work.
    #
    def self.gem_dependencies
      []
    end

    # The class of the wrapped compiler, or false if none
    # is used.
    #
    def self.compiler_class
      false
    end

    # A default instance without options.
    #
    def self.default
      @default ||= new
    end

    def self.new(*prms)
      unless available?
        raise Shift::DependencyError, "#{self} not available. " +
              "Possible fix: #{INSTRUCTIONS}"
      end
      super
    end

    # Create a new instance. Ignores the given options.
    #
    def initialize(opts={})
      self.class.gem_dependencies.each do |str|
        require str
      end
      if self.class.compiler_class
        @engine = self.class.compiler_class.new(opts)
      end
    end

    # Process the supplied string, returning the resulting `String` (with a #write method attached to it).
    #
    def process(str)
      process_plain(str).extend(StringExtension)
    end
    alias :compress   :process
    alias :compile    :process
    alias :transform  :process

    # Process the supplied string, returning the resulting `String`.
    #
    def process_plain(str)
      str.dup
    end

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
  Echo = Identity
end


