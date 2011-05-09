
Shift (draft)
=====

**State and logic-less compiler and compressor interface**

---

Shift is a generic Ruby interface to different compilers, compressors, transformers and so on. What the [Tilt](https://github.com/rtomayko/tilt) gem does for template languages, Shift does for stuff that compiles in one step, without stateful template logic.

* [Documentation](http://rubydoc.info/github/jbe/shift/master/frames)
* [File type mappings](http://rubydoc.info/github/jbe/shift/master/Shift)

### Installation

```bash

  gem install tilt

```

### Usage

To read and process a file, using the preferred available default component for that filetype:

```ruby

  Shift.read('thefile.js') # => minified js string

```

Or to read, process, and then write:

```ruby

  Shift.read('canopy.sass').write('canopy.css')

```

The components can also be used directly:

```ruby

  cc = Shift::ClosureCompiler.new(:compilation_level => 'ADVANCED_OPTIMIZATIONS')
  minified_js_string  = cc.read(path)

```

To simply process a string, or to process and save a string:

```ruby

  md = Shift::RDiscount.new
  md.process("hello *there*") # => "<p>hello <em>there</em></p>"
  md.process("hello *there*").write('message.html')

```
To see if a component is available (check if the gem is installed and so on):

```ruby

  Shift::YUICompressor.available?.

```

To get the first available preferred default component class for a file:

```ruby

  Shift['somefile.js'] # => Shift::UglifyJS

```

You can also do:

```ruby

  Shift[:md] # => Shift::RDiscount

```

### Available engines

* UglifyJS
* ClosureCompiler
* YUICompressor
* CoffeeScript
* Sass
* RDiscount
* Redcarpet


### Why not use or extend Tilt instead?

I am making a separate library for this rather than extending Tilt, because i would usually only need one of the two in a given context. One and two step compilation are somewhat different things. Shift is more on the build side. Tilt is more on the dynamic side.

### Bye

Bye Bye, see you. There are proper [docs](http://rubydoc.info/github/jbe/shift/master/frames) if you want more. And once again, [the mappings are there too](http://rubydoc.info/github/jbe/shift/master/Shift). Contributions and feedback is welcome, of course.

---

© 2011 Jostein Berre Eliassen. See LICENSE for details.
