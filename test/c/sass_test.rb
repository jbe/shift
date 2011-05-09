require File.join(File.dirname(__FILE__), 'identity_test')


class SassTest < IdentityTest

  def subject
    Shift::Sass
  end

  def transformations
    {"#footer\n  :height 200px" => "#footer {\n  height: 200px; }\n"}
  end

end
