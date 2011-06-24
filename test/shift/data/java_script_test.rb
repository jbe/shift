
require File.join(File.dirname(__FILE__), '../../helper')
require File.join(File.dirname(__FILE__), './basic_file_test')


class JavaScriptTest < BasicFileTest

  JavaScript = Shift::Data::JavaScript

  def scripts
    { 'hello();'        => 'hello()',
      "var x;\nx = 23;" => 'x=23' }
  end

  [:minify, :uglify, :closure_compile, :yui_compress].each do |met|
    test(met.to_s) do
      scripts.each do |src, expected|
        assert_includes Shift(src, 'f.js').send(met).to_s, expected
      end
    end
  end

  test 'rename' do
    assert_equal('f.min.js',
      Shift('x=0', 'f.js').minify.path)
  end

end
