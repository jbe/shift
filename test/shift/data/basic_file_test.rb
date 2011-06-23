require File.join(File.dirname(__FILE__), '../../helper')


class BasicFileTest < TestCase

  BasicFile = Shift::Data::BasicFile

  SHORT_CONTENTS = 'hello'
  LONG_CONTENTS  = 'b'*(2**19)
  SHORT_PATH     = './path//to/file.name'
  LONG_PATH      = '.long.file'

  def short_file
    BasicFile.new(SHORT_CONTENTS, SHORT_PATH)
  end

  def long_file
    with_tempfile(LONG_CONTENTS, LONG_PATH) do |path|
      yield BasicFile.read(path)
    end
  end

  test 'concat' do
    with_tempfile('hello ') do |a|
      with_tempfile('there') do |b|
        assert_equal 'hello there', BasicFile.concat(a, b).to_s
        assert_equal 'hello there', Shift.concat(a, b).to_s
      end
    end
  end


  #
  
  test 'data type auto select' do
    assert_instance_of String, short_file.data
    long_file do |f|
      assert_kind_of IO, f.data
    end
  end
  
  test 'string to io' do
    assert_equal 'hello', short_file.data_io.read
  end

  test 'io to string' do
    assert_equal ('b' * (2**19)), long_file {|f| f.data_string }
  end

  test 'append' do
    assert_equal 'hello there', (short_file << ' there').to_s
  end

  test 'write' do
    with_tempfile('', 'test.write.target') do |path|
      BasicFile.new('hoolabandoola', path).write
      assert_equal('hoolabandoola', File.read(path))
    end
  end

  test 'copy' do
    a = short_file
    b = a.copy
    b << ' there!'
    assert_equal 'hello there!', b.data
    assert_equal 'hello', a.data
  end


  # Path stuff:

  test 'full ext' do
    bf = BasicFile.new('yo', '/path/some.long.file.name')
    assert_equal '.long.file.name', bf.full_ext
  end


  # Actions:
  
  test 'process' do
    r = short_file.process {|data| data += ' there!' }
    assert_equal 'hello there!', r.to_s
  end

  test 'chomp and append' do
    assert_equal('./file.fmt', 
      short_file.process(:chomp => '.name', :append => '.fmt',
        :move => '.').path)
  end

  test 'move' do
    assert_equal '/tmp/file.name', short_file.process(
      :move => '/tmp').path
    assert_equal '/tmp/to/file.name', short_file.process(
      :move => '/tmp', :from => 'path').path
    assert_equal '/tmp/file.name', short_file.process(
      :move => '/tmp', :from => './path/to').path
  end

  test 'rename' do
    assert_equal './path//to/enlightenment', short_file.process(
      :rename => 'enlightenment', :chomp => '.name').path
    assert_equal './path//to/a.name', short_file.process(
      :rename => 'a').path
  end

  test 'gzip' do
    gz = Shift('hello', 'message').gzip
    assert_kind_of Shift::Data::Gzip, gz
    assert_equal 'message.gz', gz.path
    assert_kind_of String, gz.data_string
  end
end



