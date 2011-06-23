

module Shift

  # Contains wrappers for the different formats supported by Shift.
  # See Shift::Data::BasicFile
  #
  module Data

    MAP = {}
    
    def self.map(hsh)
      hsh.each do |k, v|
        case k
        when String then MAP[k] = v
        when Array  then k.each {|kk| MAP[kk] = v }
        else raise "#{k.inspect} should have been string or string array"
        end
      end
    end


    map(                        # sorted by:
      #'builder'              => :Builder,
      'coffee'                => :CoffeeScript,
      #%w{erb rhtml}         => :ERBTemplate,
      'gz'                    => :Gzip,
      # 'haml'                 => :HamlTemplate,
      # 'str'                  => :InterpolatedString,
      'js'                    => :JavaScript,
      # 'less'                 => :LessCSS,
      # 'liquid'               => :LiquidTemplate,
      # 'mab'                  => :Markaby,
      %w{md mkd markdown}     => :Markdown,
      # 'nokogiri'             => :Nokogiri,
      # 'radius'               => :RadiusTemplate,
      # 'rb'                   => :RubySource,
      # 'rdoc'                 => :RDoc,
      'sass'                  => :Sass
      # 'scss'                 => :Scss,
      # 'temple.sexp'          => :TempleSexp,
      # 'textile'              => :Textile,
      # 'creole'               => :WikiCreole
    )

    autoload :BasicFile,          'shift/data/basic_file'

    autoload :Builder,            'shift/data/builder'
    autoload :CoffeeScript,       'shift/data/coffee_script'
    autoload :ERBTemplate,        'shift/data/erb_template'
    autoload :Gzip,               'shift/data/gzip'
    autoload :HamlTemplate,       'shift/data/haml_template'
    autoload :InterpolatedString, 'shift/data/interpolated_string'
    autoload :JavaScript,         'shift/data/java_script'
    autoload :LessCSS,            'shift/data/less_css'
    autoload :LiquidTemplate,     'shift/data/liquid_template'
    autoload :Markaby,            'shift/data/markaby'
    autoload :Markdown,           'shift/data/markdown'
    autoload :Nokogiri,           'shift/data/nokogiri'
    autoload :RadiusTemplate,     'shift/data/radius_template'
    autoload :RubySource,         'shift/data/ruby_source'
    autoload :RDoc,               'shift/data/rdoc'
    autoload :Sass,               'shift/data/sass'
    autoload :Scss,               'shift/data/scss'
    autoload :Textile,            'shift/data/textile'
    autoload :WikiCreole,         'shift/data/wiki_creole'

  end
end


