require File.join(File.dirname(__FILE__), '..', 'interface_test')


class ClosureCompilerTest < InterfaceTest

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

  def name_transformations
    { 'script.js' => 'script.min.js' }
  end

end
