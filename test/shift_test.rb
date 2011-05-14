require File.join(File.dirname(__FILE__), 'helper')



# Test Shift base module methods
class ShiftTest < TestCase

  test 'read nonexistant file' do
    assert_raises(Errno::ENOENT) do
      Shift.read('/piglets/seriously.echo')
    end
  end

  test 'read' do
    with_tempfile('orangutan') do |path|
      assert_equal Shift.read(path), 'orangutan'
    end
  end

  test 'concat' do
    with_tempfile('hello ') do |a|
      with_tempfile('there') do |b|
        assert_equal Shift.concat(a, b), 'hello there'
      end
    end
  end

  test 'constructors' do
    assert_instance_of Shift::String, Shift()
    assert_instance_of Shift::String, Shift.new
  end

end

