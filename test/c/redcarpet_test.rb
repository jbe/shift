require File.join(File.dirname(__FILE__), 'identity_test')


class RedCarpetTest < IdentityTest

  def subject
    Shift::Redcarpet
  end

  def instance
    subject.new
  end

  def transformations
    { 'hello' => "<p>hello</p>\n" }
  end

end
