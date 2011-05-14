require File.join(File.dirname(__FILE__), '..', 'interface_test')


class RDiscountTest < InterfaceTest

  def subject
    Shift::RDiscount
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
