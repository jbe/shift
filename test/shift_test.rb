require File.join(File.dirname(__FILE__), 'helper')



# Test Shift base module methods
class ShiftTest < TestCase


  test 'shortcuts' do
    assert_raises(Errno::ENOENT) do
      Shift.read('there_should_not_be_any_piglets_here.echo')
    end
  end

  test 'lookup' do
    assert_equal Shift::Data::BasicFile, Shift[nil]
    assert_equal Shift::Data::BasicFile, Shift['some.file']
    assert_equal Shift::Data::Gzip, Shift['file.gz']
    assert_equal Shift::Data::Gzip, Shift['/lala/file.gz']
  end

  test 'constructors' do
    assert_instance_of Shift::Data::BasicFile, Shift()
    assert_instance_of Shift::Data::BasicFile, Shift.new
    assert_instance_of Shift::Data::BasicFile, Shift('hey', 'file')
    assert_instance_of Shift::Data::BasicFile, Shift.new('hey', 'file')
  end


end

