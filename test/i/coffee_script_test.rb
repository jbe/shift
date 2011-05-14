require File.join(File.dirname(__FILE__), '..', 'interface_test')


class CoffeeScriptTest < InterfaceTest

  def subject
    Shift::CoffeeScript
  end

  def options
    {:bare => true}
  end

  def transformations
    {
      'hello'           => 'hello;',
      'x = 23'          => "var x;\nx = 23;",
      'frog -> "croak"' =>
        "frog(function() {\n  return \"croak\";\n});"
    }
  end

  def name_transformations
    { 'cup.coffee' => 'cup.js' }
  end

end
