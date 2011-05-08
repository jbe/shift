require File.join(File.dirname(__FILE__), '..', 'helper')

# Test Shift::Identity.
class IdentityTest < TestCase

  def subject
    Shift::Identity
  end

  def instance
    subject.new
  end

  def sample_transformations
    {
      'echo'        => 'echo',
      ''            => ''
    }
  end

  test 'instructions' do
    unless subject == Shift::Identity
      refute_same subject::INSTRUCTIONS,
                  subject.superclass::INSTRUCTIONS
                  'gives instructions'
    end
  end

  test 'has_default_instance' do
    assert_instance_of subject, subject.default
  end

  test 'process' do
    sample_transformations.each do |a, b|
      assert_equal b, instance.process(a)
    end
  end

  # the usual ruby system file errors will just pass through,
  # no use in testing for them.

  test 'read' do
    sample_transformations.each do |a, b|
      with_tempfile(a) do |path|
        assert_equal b, instance.read(path)
      end
    end
  end

  test 'read and write' do
    sample_transformations.each do |a, b|
      with_tempfile(a) do |src_path|
        with_tempfile do |trg_path|
          instance.read(src_path).write(trg_path)
          assert_equal b, IO.read(trg_path)
        end
      end
    end
  end

  test 'process and write' do
    sample_transformations.each do |a, b|
      with_tempfile do |path|
        instance.process(a).write(path)
        assert_equal b, IO.read(path)
      end
    end
  end

  test 'initialize when unavailable' do
    wrap = Class.new(subject).extend(Unavabelizer)
    assert_raises(Shift::DependencyError) { wrap.new }
  end

end
