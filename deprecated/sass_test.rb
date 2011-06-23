require File.join(File.dirname(__FILE__), '..', 'interface_test')


class SassTest < InterfaceTest

  def subject
    Shift::Sass
  end

  def transformations
    {"#footer\n  :height 200px" => "#footer {\n  height: 200px; }\n"}
  end

  def name_transformations
    { 'sheet.sass' => 'sheet.css' }
  end


end
