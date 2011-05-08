require File.join(File.dirname(__FILE__), 'identity_test')


class ClosureCompilerTest < IdentityTest

  def subject
    Shift::ClosureCompiler
  end

  def sample_transformations
    {
      'echo'        => 'echo',
      ''            => ''
    }
  end

  test 'options'
end
