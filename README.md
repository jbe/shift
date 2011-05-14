
Shift
=====

**Compiler and compressor interface**

---

Shift is a generic Ruby interface to different compilers, compressors, transformers and so on. It is also an easy way to chain actions that transform something and build compiler chains.

* Installation: `gem install shift`
* API Documentation
  * [Latest Gem](http://rubydoc.info/gems/shift/frames)
  * [Github master](http://rubydoc.info/github/jbe/shift/master/frames)
* [Default mappings](https://github.com/jbe/shift/blob/master/lib/shift/mappings.rb)

Shift contains:

* A convention for compiler interfaces
* A collection of such interfaces for common compilers, compressors etc.
* A way to describe actions that can be performed on a given format (such as `:render` for `markdown` files)
  * A way to map such format actions to lists of compilers performing that action
  * A way to return the best available compiler from such a list
* Default mappings for all of the above


This means you can do things like

```ruby

(Shift.read('cup.coffee').compile.compress << '/* pidgeon */'
  ).gzip.write

```

This reads `cup.coffee`, compiles it using coffeescript, compresses it using UglifyJS, appends the pidgeon comment to the minified javascript, gzips all of that, and then saves it as `cup.min.js.gz`. Since no file name was given, it is determined automatically.

The aim is to include a large library of interfaces, which are lazy loaded on demand, to allow a huge variety of operations.


### Examples

```ruby

  str = Shift("hello", "hi.markdown") # => "hello"
  str.class # => Shift::String
  str.name # => "hi.markdown"
  
  result = str.render # => "<p>hello</p>"
  result.name # => "hi.html"

```

The `Shift::String` works like a normal string, except that it has an associated name, and that it can be transformed like we just did. The string name is theoretical only; it does not necessarily exist as a file. Therefore, it can also simply represent the format. There are methods to read and write from file paths however:

```ruby

  str_a = Shift.read('script.js') # => "var hello; hello = 31;"
  str_a.class # => Shift::String

  str_b = Shift('hello', 'message.txt')
  str_b.write
  str_b.write('message_copy.txt')

```

Pretty handy. It can automatically write the string to the path that it automatically figured out.

Now, in the first example, how did it know how to render markdown? Because i have RDiscount installed and it is the preferred default interface for doing `:render` to `.markdown` files.

```ruby

  str = Shift("hello", "hi.markdown") # => "hello"
  str.render # => "<p>hello</p>"
  str.interface # => #<Shift::RDiscount:0xa0ad818>

  Shift[:markdown] # => Shift::RDiscount
  Shift[:md] # => Shift::RDiscount
  Shift['somefile.js'] # => Shift::UglifyJS

  Shift[:js, :compress] # => Shift::UglifyJS
  Shift[:js, :gzip]     # => Shift::ZlibCompressor

  puts Shift.inspect_actions
  # =>
  # GLOBAL: gzip
  # echo: default
  # coffee: compile
  # gzip, gz: inflate
  # js: compress
  # md, markdown: render
  # sass: compile

```
If i tried to look up a format, and it had mappings, but none of the underlying handlers were available, Shift would raise a `Shift::DependencyError` including installation instructions.

What if i want to work with the interfaces without any magic?

```ruby

  Shift::ClosureCompiler.available? # => true

  iface = Shift::ClosureCompiler.new(
    :compilation_level => 'ADVANCED_OPTIMIZATIONS')
  iface.process(str)
  iface.rename(file_path)

```

Being interfaces, they all work the same way.


### Defining new mappings

```ruby

  Shift.map('myformat', 'myaliasformat',
    :default => :crush,
    :crush => 'MyFormatCrusher',
    :stabilize => %w{MyFormatStabilizer AlternativeMyFormatStabilizer}
    )

```

Or globally, for all formats:

```ruby
  Shift.global.map(
    :mix_up => 'Mixuper'
    )
```

To reset all mappings:

```ruby

  Shift::MAP = {}

```

* [Default mappings](https://github.com/jbe/shift/blob/master/lib/shift/mappings.rb)


### Shifter command line tool

There is also a command line tool called `shifter`.

```bash

  shifter

  shifter sheet.sass
  shifter file.js compress
  shifter style.s compile sass
  
  some-tool | shifter - js > myfile.min.js
  some-tool | shifter - js compress > myfile.min.js

```


### Bye

Bye Bye, see you. Contribute some interfaces and mappings if you want to.

---

© 2011 Jostein Berre Eliassen. See LICENSE for details.
