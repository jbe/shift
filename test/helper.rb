require 'tempfile'

class TestCase < MiniTest::Unit::TestCase
  def self.test(name, &block)
    test_name = "test_#{name.gsub(/\s+/, '_')}".to_sym
    defined = instance_method(test_name) rescue false
    raise "#{test_name} already defined in #{self}" if defined

    block ||= proc { skip }
    define_method(test_name, &block)
  end

  def with_tempfile(data=nil)
    file = Tempfile.new('shift_test')
    file.write(data) if data
    file.close
    yield(file.path)
    file.unlink
  end

  def file(name)
    File.join(File.dirname(__FILE__), 'data', name)
  end

end





module Unavabelizer
  def available?
    false
  end
end


