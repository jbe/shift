require File.join(File.dirname(__FILE__), '..', 'interface_test')


class YUICompressorTest < InterfaceTest

  FUNCTION = <<-eos
    function hello(name) {
      alert('Hello, ' + name);
    }
  eos

  INVOCATION = <<-eos
    hello('New user');
  eos

  def subject
    Shift::YUICompressor
  end

  def options
    {}
  end

  def transformations
    {
      [FUNCTION, INVOCATION].join("\n") =>
        "function hello(name){alert(\"Hello, \"+name)}hello(\"New user\");",
      FUNCTION    => "function hello(name){alert(\"Hello, \"+name)};",
      INVOCATION  => "hello(\"New user\");"
    }
  end

  def name_transformations
    { 'script.js' => 'script.min.js' }
  end

end
