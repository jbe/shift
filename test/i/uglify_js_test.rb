require File.join(File.dirname(__FILE__), '..', 'interface_test')


class UglifyJSTest < InterfaceTest

  FUNCTION = <<-eos
    function hello(name) {
      alert('Hello, ' + name);
    }
  eos

  INVOCATION = <<-eos
    hello('New user');
  eos

  def subject
    Shift::UglifyJS
  end

  def options
    {}
  end

  def transformations
    {
      [FUNCTION, INVOCATION].join("\n") =>
        "function hello(a){alert(\"Hello, \"+a)}hello(\"New user\")",
      FUNCTION    => "function hello(a){alert(\"Hello, \"+a)}",
      INVOCATION  => "hello(\"New user\")"
    }
  end

  def name_transformations
    { 'script.js' => 'script.min.js' }
  end

end
