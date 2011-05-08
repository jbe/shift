require File.join(File.dirname(__FILE__), 'helper')
require File.join(File.dirname(__FILE__), 'support')




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
    with_tempfile do |path|
      Shift.read(file('letter.echo')).write(path)
      assert_equal(IO.read(file 'letter.echo'), IO.read(path))
    end
  end


  # mappings

  test 'has mappings' do
    assert_kind_of Hash, Shift::MAPPINGS
  end

  test 'reads unmapped file' do
    assert_raises(Shift::UnknownFormatError) do
      Shift.read('oy-oy-oy.noformatforthis')
    end
  end

  test 'gets available mapping' do
    assert_equal Shift[:echo], Shift::Identity, 'given type'
    assert_equal Shift['treaty.null'], NullComponent, 'given path'
    assert_equal Shift['some/path/hey.bingo.bongo'],
                 NullComponent, 'with detailed mapping'
  end

  test 'prioritizes' do
    assert_equal Shift['file.null'], NullComponent,
                 'first when available'
    assert_equal Shift['file.prioritized'], NullComponent,
                 'second when available but not first'
  end

  test 'raises DependencyError' do
    begin
      Shift[:unavailable] # defined in test/support.rb
      assert false, 'when no components available'
    rescue Shift::DependencyError => err
      assert_match /meditate/, err.message, 'with helpful message'
    end
  end

end

