require File.join(File.dirname(__FILE__), 'identity_test')


class UglifyJSTest < IdentityTest

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
    {:compilation_level => 'ADVANCED_OPTIMIZATIONS'}
  end

  def transformations
    {
      [FUNCTION, INVOCATION].join("\n") =>
        "function hello(a){alert(\"Hello, \"+a)}hello(\"New user\")",
      FUNCTION    => "function hello(a){alert(\"Hello, \"+a)}",
      INVOCATION  => "hello(\"New user\")"
    }
  end

end
