
module Shift
  module Mapper

    MAP = {}

    # Register mappings for a file type.
    #
    def map(*args)
      actions   = parse_actions(args.pop)
      synonyms  = args.map {|t| t.to_s }
      type      = synonyms.shift

      begin
        backup = MAP[type]
        (MAP[type] ||= Hash.new).merge!(actions)
        verify_acyclic_mappings
      rescue Shift::MappingError
        if backup
          MAP[type] = backup
        else
          MAP.delete(type)
        end
        raise
      end

      synonyms.each {|s| synonym(s, type) }
    end


    # Register a synonymous file type
    #
    def synonym(new_term, old_term)
      MAP[new_term] = MAP[old_term]
    end

    # Get the preferred available class mapped to match the
    # given filename or extension.
    #
    # @raise [UnknownFormatError] when none of the mappings match.
    #
    # (see Shift.best_available_mapping_for)
    #
    def [](filename, action=:default)
      pattern = File.basename(filename.to_s.downcase)
      until pattern.empty?
        return best_available(pattern, action) if MAP[pattern]
        pattern.sub!(/^[^.]*\.?/, '')
      end
      raise UnknownFormatError, "no mapping matches #{file}"
    end

    def inspect_actions
      MAP.group_by {|k,v| v }.map do |actions, map_ary|

        
        types = map_ary.map {|xhsh| xhsh.first }.flatten.uniq

        actions = actions.select do |name, action|
          action.is_a?(Array)
        end.map {|k,v| k }

        "#{types.join(', ')}: #{actions.join(', ')}"
      end.join("\n")
    end

private

    def parse_actions(actions)
      unless actions.is_a?(Hash)
        actions = {:default => Array(actions)}
      end
      actions.each do |name, action|
        case action
        when Symbol then nil
        when Array  then actions[name] = action.map {|cls| cls.to_s }
        when Class  then actions[name] = [action.to_s]
        else raise  MappingError, "bad handler: #{action.inspect}"
        end
      end
    end

    # @raise [DependencyError] when none of the mapped
    #   implementations are available.
    #
    # @return [Class] The preferred available class associated
    #   with the file or extension.
    #
    def best_available(type, action=:default)
      mappings = mappings_for(type, action)

      mappings.each do |kls_name|
        kls = const_get(kls_name)
        return kls if kls.available?
      end

      raise DependencyError, "no implementation available for " +
        [type, action].inspect + dependency_help(mappings)
    end

    def dependency_help(mappings)
      if mappings.any?
        " Possible solution: " + const_get(mappings.first).instructions
      else ''; end
    end


    def mappings_for(type, action, visited=[])
      action = action.to_sym
      result = MAP[type][action]

      unless result
        raise MappingError, "invalid action #{action.inspect} " +
                            "for type #{type.inspect}"
      end

      if result.is_a?(Array) # mapping
        result
      else # link
        if (visited << action).include?(result)
          raise MappingError, 'Cycle detected: ' + visited.inspect
        end
        mappings_for(type, result, visited)
      end
    end

    def verify_acyclic_mappings
      MAP.each do |type, actions|
        actions.each_key do |action|
          mappings_for(type, action)
        end
      end
    end

  end
end
