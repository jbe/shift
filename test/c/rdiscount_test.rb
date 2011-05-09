require File.join(File.dirname(__FILE__), 'identity_test')


class RDiscountTest < IdentityTest

  def subject
    Shift::RDiscount
  end

  def instance
    subject.new
  end

  def transformations
    { 'hello' => "<p>hello</p>\n" }
  end

end
