module Shift
  class InterfaceList

    # Create a new InterfaceList, given an array of class names
    # of shift interfaces. Immutable once created.
    #
    def initialize(ifaces)
      @interfaces = ifaces
    end

    def to_hash
      @interfaces.dup
    end

    def eql?(other)
      @interfaces.eql? other.to_hash
    end
    alias :== :eql?

    def hash
      @interfaces.hash
    end

    def inspect
      'InterfaceList' + @interfaces.inspect
    end

    # Pick the preferred available interface.
    #
    # @raise [DependencyError] when none of the interfaces
    #   are available.
    #
    # @return [Class] The preferred available class
    #
    def pick
      each_class {|kls| return kls if kls.available? }
      raise DependencyError, "nothing available: " +
        help_string
    end

  private

    def help_string
      if @interfaces.any?
        @interfaces.inspect + " Possible solution: " +
          first_class.instructions
      else
        'no interfaces mapped'
      end
    end

    def each_class
      @interfaces.each do |name|
        yield get_iface(name)
      end; nil
    end

    def first_class
      get_iface(@interfaces.first)
    end

    def get_iface(name)
      Shift.const_get(name)
    end

  end
end
