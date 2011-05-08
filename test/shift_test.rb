require File.join(File.dirname(__FILE__), 'helper')
require File.join(File.dirname(__FILE__), 'support')


require 'tempfile'





# Test Shift base module methods
class ShiftTest < TestCase



  test 'read nonexistant file' do
    assert_raises(Errno::ENOENT) do
      Shift.read('/ubongobaluba-hepp-piglets/seriously.echo')
    end
  end

  test 'read file' do
    assert_match Shift.read(file 'letter.echo'),
                 /electric power drill/
  end

  test 'reads existing file and writes result' do
    with_tempfile do |tmp|
      Shift.read(file('letter.echo')).write(tmp.path)
      assert_equal(IO.read(file 'letter.echo'), IO.read(tmp.path))
    end
  end


  # mappings

  test 'has mappings' do
    assert_kind_of Hash, Shift::MAPPINGS
  end

  test 'read unmapped file' do
    assert_raises(Shift::UnknownFormatError) do
      Shift.read('oy-oy-oy.noformatforthis')
    end
  end

  test 'returns available mapping for a file type' do
    assert_equal Shift[:echo], Shift::Identity
  end

  test 'returns available mapping for a path' do
  end

  test 'returns deeper mapping for a path' do
  end

  test 'returns first prioritized mapping when it is available' do
  end

  test 'returns second prioritized mapping when it is available but not the first' do
  end

  test 'raises DependencyError when no components available' do
    begin
      Shift[:unavailable] # defined in test/support.rb
      assert false, 'did not raise'
    catch DependencyError => err
      assert_match err, /meditate/, 'bad message'
    end
  end

end

# Test Shift::Identity.
class IdentityTest < TestCase
  test 'provides default instance'
  test 'allows accessing options'
  test 'processes'
  test 'reads and compiles'
  # the usual ruby system file errors will just pass through,
  # no use in testing for them.
  test 'reads, compiles and writes'
  test 'compiles and writes'
  test 'throws DependencyError if used when not available'
end
