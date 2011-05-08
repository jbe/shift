
module Shift
  
  # Mappings from file names to implementation classes. The
  # classes are listed in order of preference per type.
  #
  MAPPINGS = {
    'echo'    => %w{ Identity },
    'js'      => %w{ UglifyJS ClosureCompiler YUICompressor },
    'coffee'  => %w{ CoffeeScript },
    'sass'    => %w{ Sass },
    'md'      => %w{ RDiscount }
  }

  # @raise [DependencyError] when none of the mapped
  #   implementations are available.
  #
  # @return [Class] The preferred available class associated
  #   with the file or extension.
  #
  def self.best_available_mapping_for(key)
    MAPPINGS[key].each do |kls_name|
      kls = const_get(kls_name)
      return kls if kls.available?
    end
    raise DependencyError, "no implementation available for #{key}.\n" +
          "Possible solution: #{kls::INSTRUCTIONS}"
  end
end


