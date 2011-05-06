
Shift (draft)
=====

**State and logic-less compiler and compressor interface**

---

Shift is a generic Ruby interface to different compilers, compressors, transformers and so on. What the [Tilt](https://github.com/rtomayko/tilt) gem does for template languages, Shift does for stuff that compiles in one step, without stateful template logic.

* [Docs](http://rubydoc.info/github/jbe/shift/master/frames)
* [Available Shift components and their mappings.](http://rubydoc.info/github/jbe/shift/master/Shift).

### Usage

To read and process a file, using the best available default component for that filetype:

```ruby

  Shift.read('thefile.js') # => minified js string

```

Or to read, process, and then write:

```ruby

  Shift.readwrite(
    'canopy.sass' => 'canopy.css',
    'flower.js'   => 'flower.min.js'
    )

```

The components can also be used directly:

```ruby

  cc = Shift::ClosureCompiler.new(:compilation_level => 'ADVANCED_OPTIMIZATIONS')

  cc.read(path) # => processed contents
  cc.readwrite('pickle.md' => 'pickle.html')

  md = Shift::RDiscount.new

  md.process("hello *there*") # => "<p>hello <em>there</em></p>"
  md.write("hello there" => 'message.html')

```
To see if a component is available:

```ruby

  Shift::YUICompressor.available? # => true if the yui gem is there and okay.

```

To get the first available preferred default component class for a file:

```ruby

  Shift['somefile.js'] # => Shift::UglifyJS

```

You can also do:

```ruby

  Shift[:md] # => Shift::RDiscount

```

### Why not just use or extend Tilt for one step compilation/rendering as well?

I am making a separate library for this rather than extending Tilt, because i would usually only need one of the two in a given context. One and two step compilation are somewhat different things. Shift is more on the build side. Tilt is more on the dynamic side.

### Bye

Bye Bye, see you. There are proper [docs](http://rubydoc.info/github/jbe/shift/master/frames) if you want more. Contributions and feedback is welcome, of course.

---

© 2011 Jostein Berre Eliassen. See LICENSE for details.
