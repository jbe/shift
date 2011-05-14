
module Shift

  # The default Shift interface, from which other interfaces must
  # inherit. Also works as an identity function or echo server, in
  # that it echoes what it is given.
  #
  class Interface

    # One-liner on what the user can do to make it available.
    # Used in DependencyError.
    #
    def self.instructions
      if gem_dependencies.any?
        'gem install ' + gem_dependencies.join(' ')
      else
        'Google it :)'
      end
    end

    # Wether the requirements are met in the current environment.
    # Typically checks if the required gems and/or command line
    # stuff is available.
    #
    def self.available?
      gem_dependencies.all? {|d| Gem.available?(d) }
    end

    # A list of Rubygems needed for the interface to work.
    #
    def self.gem_dependencies
      []
    end

    # A list of things to be required on initialization.
    #
    def self.require_libs
      gem_dependencies
    end

    # The class of the wrapped generator, or false if none
    # is used.
    #
    def self.engine_class
      false
    end

    # The format typically produced by the generator.
    #
    def self.target_format
      false
    end

    # Whether to leave the old extension as is and append, like
    # something.css => something.css.gzip
    #
    def self.keep_extension?
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
              "Possible fix: #{instructions}"
      end
      @req ||= require_libs.each {|str| require str }
      super
    end

    # Create a new instance with the given options.
    #
    def initialize(*prms)
      if self.class.engine_class
        @engine = self.class.engine_class.new(*prms)
      end
    end

    # Process the supplied string, returning the resulting `String`.
    #
    def process(str)
      str.dup
    end
    alias :compress   :process
    alias :compile    :process
    alias :transform  :process

    # Get the default filename of a transformed file.
    # @param [String] file Path of the original file
    # @return [String] default file name for the result.
    #
    def rename(file)
      return nil if file.nil?

      unless self.class.keep_extension?
        file = file.is_a?(Symbol) ?
          file.to_s : file.chomp(File.extname(file))
      end
      if self.class.target_format
        file = file + '.' + self.class.target_format.to_s
      end
      file
    end

  end
end


