require File.join(File.dirname(__FILE__), 'identity_test')


class ClosureCompilerTest < IdentityTest

  FUNCTION = <<-eos
    function hello(name) {
      alert('Hello, ' + name);
    }
  eos

  INVOCATION = <<-eos
    hello('New user');
  eos

  def subject
    Shift::ClosureCompiler
  end

  def options
    {:compilation_level => 'ADVANCED_OPTIMIZATIONS'}
  end

  def transformations
    {
      [FUNCTION, INVOCATION].join("\n") =>
        "alert(\"Hello, New user\");\n",
      FUNCTION    => "\n",
      INVOCATION  => "hello(\"New user\");\n"
    }
  end

end
