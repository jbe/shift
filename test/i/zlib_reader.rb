require File.join(File.dirname(__FILE__), '..', 'interface_test')


class ZlibReaderTest < InterfaceTest

  def subject
    Shift::ZlibReader
  end

  def transformations
    {"\x1F\x8B\b\x00w\xC5\xCEM\x00\x03\xCBH\xCD\xC9\xC9\a\x00\x86\xA6\x106\x05\x00\x00\x00" => "hello"}
  end

  def name_transformations
    { 
      'file.js.gz' => 'file',
      'file.gz' => 'file',
      'file' => 'file',
      '' => '',
      nil => nil
      }
  end

end
