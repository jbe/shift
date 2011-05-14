require File.join(File.dirname(__FILE__), '..', 'interface_test')


class RedCarpetTest < InterfaceTest

  def subject
    Shift::Redcarpet
  end

  def instance
    subject.new
  end

  def transformations
    { 'hello' => "<p>hello</p>\n" }
  end

  def name_transformations
    { 'doc.md' => 'doc.html' }
  end

end
