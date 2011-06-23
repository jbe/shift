require File.join(File.dirname(__FILE__), '../../helper')
require File.join(File.dirname(__FILE__), './basic_file_test')


class GzipTest < BasicFileTest

  Gzip = Shift::Data::Gzip

  test 'compress and decompress' do
    assert_equal SHORT_CONTENTS, short_file.gzip.inflate.to_s
    long_file do |f|
      assert_equal LONG_CONTENTS,  f.gzip.inflate.to_s
    end
  end

  test 'name and unname' do
    assert_equal SHORT_PATH + '.gz', short_file.gzip.path
    assert_equal SHORT_PATH, short_file.gzip.inflate.path
  end

end
