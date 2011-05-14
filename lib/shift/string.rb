


module Shift

  # Mixin for things that should be transformable by Shift.
  # Classes using the mixin should implement two methods:
  # 
  # - `#data` the data to be processed
  # - `#name` the file or extension name of the data
  # 
  # This is needed for the mappings to work, even if the type
  # is not a string, and/or is not persisted to disk. In this
  # respect, the name is actually the name of the type.
  #
  module Transformable

    attr_accessor   :name
    alias :path     :name
    alias :path=    :name=
    alias :format   :name
    alias :format=  :name=

    # Get the default interface class for this transformable.
    #
    # @param [Symbol] action The action to perform.
    #   Sample: `:compress`
    # @param [String] name_override Use the specified file name or
    #   extension rather than `#name`
    # @return [Shift::Interface] The preferred available default
    #   interface
    # @raise [UnknownFormatError] when a type is needed but cannot
    #   be determined.
    # @raise [UnknownActionError] when no such action exists.
    # @raise [DependencyError] when required interfaces are 
    #   not available.
    #
    def interface(action=:default, name_override=nil)
      return action if action.is_a?(Shift::Interface)
      iface = Shift[name_override || name, action] || name_error
      iface.new
    end
    def can?(*args)
      begin
        interface(*args)
      rescue LookupError
        return false
      end
      true
    end

    # Process the string with one of the Shift interfaces.
    # @return [Shift::String] transformed Shift string.
    # (see Shift::String#interface)
    #
    def process(action=:default, name_override=nil)
      iface = interface(action, name_override)
      self.class.new(
        iface.process(data),
        iface.rename(name_override || name)
        )
    end

    def method_missing(*args)
      can?(*args) ? process(*args) : super
    end

    def respond_to?(method)
      super || can?(method)
    end

  private

    def name_error
      raise(UnknownFormatError, 'cannot determine format without clues.')
    end

  end



  # String result from one of the operations.
  # Extends string with some useful helper methods to write to
  # disk, do further transformations etc, allowing chaining of
  # operations.
  #
  class String < ::String

    include Transformable
    
    # Create a new shift string from a standard string.
    # @param [String] str The source string
    # @param [String] name A file path, partial path, or
    #   extension associated with the string.
    # @return [Shift::String] A Shift string that can be
    #   manipulated further.
    def initialize(str='', name=nil)
      super(str)
      @name = name
    end

    def data
      self
    end
    
    # Read a file and append its contents.
    #
    def read_append(path)
      data << File.read(path)
      self
    end
    alias :append_read :read_append

    # Write the string to a sepcified path.
    # @ return self
    def write(name_override=nil)
      path = name_override || name || name_error
      File.open(path, 'w') {|f| f.write(data) }
      self
    end

  end


end
