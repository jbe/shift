
class TestCase < MiniTest::Unit::TestCase
  def self.test(name, &block)
    test_name = "test_#{name.gsub(/\s+/, '_')}".to_sym
    defined = instance_method(test_name) rescue false
    raise "#{test_name} already defined in #{self}" if defined

    block ||= proc { skip }
    define_method(test_name, &block)
  end

  def with_tempfile
    file = Tempfile.new('shift_test')
    yield(file)
    file.close; file.unlink
  end

  def file(name)
    File.join(File.dirname(__FILE__), 'data', name)
  end
end

