
module Shift
  extend Mapper

  # components

  autoload :Identity,         'shift/c/identity'
  autoload :UglifyJS,         'shift/c/uglify_js'
  autoload :ClosureCompiler,  'shift/c/closure_compiler'
  autoload :YUICompressor,    'shift/c/yui_compressor'
  autoload :CoffeeScript,     'shift/c/coffee_script'
  autoload :Sass,             'shift/c/sass'
  autoload :RDiscount,        'shift/c/rdiscount'
  autoload :Redcarpet,        'shift/c/redcarpet'
  autoload :RedCarpet,        'shift/c/redcarpet'

  map(:echo, 'Identity')

  map(:js,
    :default  => :compress,
    :minify   => :compress,
    :compress => %w{UglifyJS YUICompressor ClosureCompiler}
    )

  map(:coffee,
    :default  => :compile,
    :compile  => %w{CoffeeScript}
    )

  map(:sass,
    :default  => :compile,
    :compile  => %w{Sass}
    )

  map(:md, :markdown,
    :default  => :render,
    :compile  => :render,
    :render   => %w{RDiscount Redcarpet}
    )

end

