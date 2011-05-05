require File.join(File.dirname(__FILE__), 'helper')





# Test Shift base module methods
class ShiftTest < TestCase

  test 'raises UnknownFormatError when there is no mapping' do
    assert_raises(UnknownFormatError) do
      Shift.read('/ubongobaluba-hepp-oy-oy-oy.noformatforthis')
    end
  end

  test 'raises error when reading nonexistant file' do
  end

  test 'reads and processes existing file' do
  end

  test 'reads existing file and writes result' do
  end


  # mappings

  test 'has mappings' do
    assert_kind_of Hash, Shift::MAPPINGS
  end

  test 'returns nil when no mapping is available' do
  end

  test 'returns available mapping for a file type' do
    assert_equal Shift[:js]
  end

  test 'returns available mapping for a path' do
  end

  test 'returns deeper mapping for a path' do
  end

  test 'returns first prioritized mapping when it is available' do
  end

  test 'returns second prioritized mapping when it is available but not the first' do
  end

  test 'raises DependencyError when none of the mappings are available' do

    # read
    # readwrite
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
