
module Shift

  # A mapping of actions to interfaces. Handles validation,
  # lookup, updates, link walking etc.
  #
  class ActionMap

    def initialize(fallback, actions={})
      @actions  = {}
      @fallback = fallback
      map(actions)
    end

    attr_reader :fallback

    # Return a duplicate ActionHash without fallback,
    # to be used for local queries.
    def local
      self.class.new(nil).map(@actions)
    end

    def map(actions)
      begin
        original = @actions.dup
        parse(actions)
        validate
      rescue Shift::Error
        @actions = original
        raise
      end; self
    end

    def to_hash(inherit=true)
      (inherit && @fallback) ?
        @actions.merge(@fallback) : @actions.dup
    end

    # Return a hash of mappings that are not links
    def atoms(inherit=false)
      to_hash(inherit).delete_if {|k,v| v.is_a?(Symbol) }
    end

    def eql?(other)
      (eql_id.eql? other.eql_id) &&
      (@fallback.eql? other.fallback)
    end
    alias :== :eql?

    def eql_id
      [to_hash(false), @fallback]
    end
    def hash; eql_id.hash; end

    # Look up an action
    def [](action)
      action = action.to_sym
      item = @actions[action] || (@fallback[action] if @fallback)
      item.is_a?(Symbol) ? self[item] : item
    end

    def inspect
      'ActionMap' + @actions.inspect
    end

    def dup
      self.class.new(fallback ? @fallback.dup : @fallback, @actions)
    end
    
  private

    def parse(hsh)
      hsh = {:default => hsh} unless hsh.is_a?(Hash)

      hsh.each do |name, handler|
        h = case handler
          when Symbol, InterfaceList then handler
          when Array  then handler.map {|cls| cls.to_s }
          else [handler.to_s]
        end
        @actions[name] = h.is_a?(Array) ? InterfaceList.new(h) : h
      end
    end


    def validate
      @actions.each do |name, handler|
        cycle_search(handler) if handler.is_a?(Symbol)
      end
    end

    def cycle_search(action, visited=[])
      visited << action
      item    =  @actions[action]

      raise(MappingError, "bad link #{action.inspect}") unless item

      if visited.include?(item)
        raise MappingError, 'cycle detected ' + visited.inspect
      end
      
      cycle_search(item, visited) if item.is_a?(Symbol)
    end

  end
end
