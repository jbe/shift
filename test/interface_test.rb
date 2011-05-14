require File.join(File.dirname(__FILE__), 'helper')


module Unavabelizer
  def available?; false; end
end

class InterfaceTest < TestCase

  def subject
    Shift::Echo
  end

  def instance
    @instance ||= subject.new(options)
  end

  def options
    {}
  end

  def transformations
    { 'echo' => 'echo', '' => '' }
  end

  def name_transformations
    { '' => '', 'identity.id' => 'identity.id' }
  end

  test 'instructions' do
    unless subject == Shift::Interface
      refute_same subject.instructions,
                  subject.superclass.instructions,
                  'gives instructions'
    end
  end

  test 'has_default_instance' do
    assert_instance_of subject, subject.default
  end

  test 'process' do
    transformations.each do |a, b|
      assert_equal b, instance.process(a)
    end
  end

  test 'rename' do
    name_transformations.each do |a, b|
      assert_equal b, instance.rename(a)
    end
  end


  test 'initialize when unavailable' do
    wrap = Class.new(subject).extend(Unavabelizer)
    assert_raises(Shift::DependencyError) { wrap.new }
  end

end
