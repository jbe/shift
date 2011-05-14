require File.join(File.dirname(__FILE__), 'helper')

class UnavailableInterface < Shift::Interface
  def self.instructions;  'meditate'; end
  def self.available?;     false;     end
end

class NullInterface < Shift::Interface
  def self.available?; true; end
  def process(str);    '';   end
end


class MapperTest < TestCase

  def map(*args)
    backup = Shift::MAP.dup
    Shift.map(*args)
    yield
    Shift::MAP.clear.merge!(backup)
  end

  def map_global(*args)
    backup = Shift.global.dup
    Shift.global.map(*args)
    yield
    Shift.global = backup
  end

  # ---

  test 'type lookup' do
    assert_equal Shift[:echo], Shift::Echo
  end

  test 'path long type lookup' do
    map('null.void', NullInterface) do
      assert_equal Shift['/a/b/c/treaty.null.void'], NullInterface
    end
  end

  test 'action lookup' do
    map('toupe',
      :default => %w{NullInterface},
      :custom  => %w{Interface}
      ) do
      assert_equal Shift['toupe'], NullInterface
      assert_equal Shift['toupe', :custom], Shift::Interface
    end
  end

  test 'unknown format' do
    assert_raises(Shift::UnknownFormatError) do
      Shift['thereis.noformatforthis']
    end
  end

  test 'known format and unknown action' do
    assert_raises(Shift::UnknownActionError) do
      Shift[:echo, :boil]
    end
  end

  test 'unknown format and known global action' do
    map_global(:nullify => NullInterface) do
      assert_equal Shift[:rhubarb, :nullify], NullInterface
      assert_equal Shift[nil, :nullify], NullInterface
    end
  end

  test 'known format and known global action' do
    map_global(:nullify => NullInterface) do
      assert_equal Shift[:echo, :nullify], NullInterface
    end
  end

  test 'prioritizes' do
    map(:prioritized,
      %w{UnavailableInterface NullInterface Interface}
      ) do
      assert_equal Shift[:prioritized], NullInterface
    end
  end

  test 'when unavailable' do
    map(:unavailable, %w{UnavailableInterface}*10) do
      begin
        Shift[:unavailable]
        assert false, 'raises error'
      rescue Shift::DependencyError => err
        assert_match /meditate/, err.message, 'gives help'
      end
    end
  end

  # ---

  test 'links' do
    map(:linked,
      :default    => :dog,
      :dog        => :cat,
      :cat        => :mouse,
      :mouse      => NullInterface
      ) do
      assert_equal Shift[:linked], NullInterface
    end
  end

  test 'invalid link' do
    assert_raises Shift::MappingError do
      map(:badlink, :bad_link => :space) { nil }
    end
  end

  test 'cyclic link' do
    assert_raises Shift::MappingError do
      map(:cycle,
        :back     => :onwards,
        :onwards  => :fourth,
        :fourth   => :back
        ) { nil }
    end
  end

  test 'allows mapping class' do
    map(:kluss, NullInterface) do
      assert_equal Shift[:kluss], NullInterface
    end
  end

  test 'synonym' do
    map(:blubber, :blbr, :br, %w{Interface}) do
      assert_equal Shift[:blubber], Shift::Interface
      assert_equal Shift[:blbr],    Shift::Interface
      assert_equal Shift[:br],      Shift::Interface
    end
  end
  
  test 'inspect' do
    assert_instance_of(String, Shift.inspect_actions)
  end

end

