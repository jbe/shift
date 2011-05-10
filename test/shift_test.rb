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

  test 'named action' do
    assert_equal Shift['bingo.bongo'], NullComponent
    assert_equal Shift['bingo.bongo', :custom], Shift::Identity
  end

  test 'allows mapping class' do
    Shift.map(:doodle, Doodle)
    assert_equal Shift[:doodle], Doodle
  end

  test 'synonym' do
    assert_equal Shift[:blubber], Shift::Identity
    assert_equal Shift[:blbr],    Shift::Identity
    assert_equal Shift[:br],      Shift::Identity
  end

  test 'link' do
    assert_equal Shift[:linked], Doodle
  end

  test 'invalid_action' do
    assert_raises Shift::MappingError do
      Shift[:linked, :african_swallow]
    end
  end

  test 'invalid link' do
    assert_raises Shift::MappingError do
      Shift.map(:badlink,
        :bad_link   => :space,
        )
    end
  end

  test 'cyclic link' do
    assert_raises Shift::MappingError do
      Shift.map(:cycle,
        :back     => :onwards,
        :onwards  => :fourth,
        :fourth   => :back
        )
    end
  end

  test 'bad handler' do
    assert_raises Shift::MappingError do
      Shift.map(:blumchen, :bicycle => true)
    end
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

