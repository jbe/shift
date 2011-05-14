
module Shift

  require 'shift/interface_list'
  require 'shift/action_map'

  MAP = {}

  # Herein lies the logic concerned with mapping (format, action)
  # to compiler interfaces.
  #
  class << self

    # Global actions that apply to all types
    #
    def global
      @global ||= ActionMap.new(nil)
    end
    attr_writer :global

    # Register mappings for file types.
    #
    def map(*synonyms)
      actions = synonyms.pop

      synonyms.each do |syn|
        am = MAP[syn.to_s] ||= ActionMap.new(global, actions)
      end
    end

    # Get the preferred available class mapped to the given format 
    # or path and action.
    #
    def [](name, action=:default)
      try_to_match(name) do |fmt|

        if action_map = MAP[fmt]
          if iface_list = action_map[action]
            return iface_list.pick
          else
            raise UnknownActionError,
              "#{action.inspect} with format #{name.inspect}."
          end
        end
        return global[action].pick if global[action]
      end
      raise UnknownFormatError, "no mappings for #{name}"
    end


    def synonyms
      MAP.group_by do |name, actions|
        actions
      end.map do |action_map, hsh_ary|
        hsh_ary.map {|k,v| k }.flatten.uniq
      end
    end

    def action_overview(globals=false)
      result = {}
      synonyms.each do |group|
        result[group] = group.map do |fmt|
          MAP[fmt].atoms(globals).keys
        end.uniq
      end
      result
    end

    def inspect_actions
      buf = []
      buf << "GLOBAL: #{global.atoms(true).keys.join(', ')}"

      action_overview.each do |types, actions|
        buf << "#{types.join(', ')}: #{actions.join(', ')}"
      end

      buf.join("\n")
    end

  private

    # Given a file name, yield all the formats it could match.
    #
    def try_to_match(name)
      return yield name if name.nil?

      pattern = File.basename(name.to_s.downcase)
      until pattern.empty?
        yield pattern
        pattern.sub!(/^[^.]*\.?/, '')
      end
    end

  end
end
