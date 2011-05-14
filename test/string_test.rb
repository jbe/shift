require File.join(File.dirname(__FILE__), 'helper')


class StringTest < TestCase

  test 'format' do
    assert_nil Shift::String.new.format
    assert_equal Shift::String.new('hey', :md).format, :md
  end

  test 'read_append' do
    with_tempfile('cauliflower', '.md') do |path|
      s = Shift::String.new
      s.read_append(path)
      assert_equal s, 'cauliflower'
    end
  end
  
  test 'write' do
    with_tempfile('', 'md') do |path|
      Shift::String.new('hello', path).write
      assert_equal IO.read(path), 'hello'
    end
  end
  
  
  test 'process and type override' do
    assert_equal Shift::String.new('hey', :pig).
      process(:render, :md), "<p>hey</p>\n"
  end
  
  test 'dynamic method chaining' do
    r = Shift::String.new('42', 'life.coffee').compile.minify
    assert_match r, /42/
    assert_equal r.name, 'life.min.js'
    Shift::String.new('hello').gzip
  end

end
