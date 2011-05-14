
module Shift

  global.map(
    :gzip => 'ZlibWriter'
    )

  map(:echo, 'Echo')

  map(:coffee,
    :default  => :compile,
    :compile  => 'CoffeeScript'
    )

  #map(:haml,
  #  :default  => :compile,
  #  :compile  => 'Haml'
  #  )

  #map('haml.compiled',
  #  :default  => :render,
  #  :render   => 'HamlTemplate'
  #  )

  #map(:rbt,
  #  :default  => :render,
  #  :render   => 'RubyTemplate'
  #  )

  map(:gz,
    :default  => :inflate,
    :decompress => :inflate,
    :unzip    => :inflate,
    :inflate  => 'ZlibReader'
    )

  map(:js,
    :default  => :compress,
    :minify   => :compress,
    :compress => %w{UglifyJS YUICompressor ClosureCompiler}
    )

  map(:md, :markdown,
    :default  => :render,
    :compile  => :render,
    :render   => %w{RDiscount Redcarpet}
    )

  map(:sass,
    :default  => :compile,
    :compile  => 'Sass'
    )

end

