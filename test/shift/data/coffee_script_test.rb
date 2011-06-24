require File.join(File.dirname(__FILE__), '../../helper')
require File.join(File.dirname(__FILE__), './basic_file_test')


class CoffeeScriptTest < BasicFileTest

  CoffeeScript = Shift::Data::CoffeeScript

  def transformations
    {
      'hello'           => 'hello;',
      'x = 23'          => "var x;\nx = 23;",
      'frog -> "croak"' =>
        "frog(function() {\n  return \"croak\";\n});"
    }
  end

  test 'compile' do
    transformations.each do |src, expected|
      assert_equal expected, Shift(src, 'cup.coffee').compile(
        :bare => true).to_s
      assert_equal expected, Shift(StringIO.new(src), 'cup.coffee').compile(
        :bare => true).to_s
    end
  end

  test 'rename' do
    assert_equal 'cup.js', Shift('x=0', 'cup.coffee').compile.path
  end

end
