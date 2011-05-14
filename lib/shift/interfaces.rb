

module Shift

  autoload :Interface,        'shift/interface'

  autoload :Echo,             'shift/i/echo'
  autoload :UglifyJS,         'shift/i/uglify_js'
  autoload :ClosureCompiler,  'shift/i/closure_compiler'
  autoload :YUICompressor,    'shift/i/yui_compressor'
  autoload :CoffeeScript,     'shift/i/coffee_script'
  autoload :Sass,             'shift/i/sass'
  autoload :RDiscount,        'shift/i/rdiscount'
  autoload :Redcarpet,        'shift/i/redcarpet'
  autoload :RedCarpet,        'shift/i/redcarpet'

  autoload :ZlibReader,       'shift/i/zlib_reader'
  autoload :ZlibWriter,       'shift/i/zlib_writer'

end
