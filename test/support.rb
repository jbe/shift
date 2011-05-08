
class UnavailableComponent < Shift::Identity
  
  INSTRUCTIONS = 'meditate.'

  def available?
    false
  end

end

class NullComponent

  def available?
    true
  end

  def process(str)
    ''
  end

end


Shift::MAPPINGS['unavailable'] = ['UnavailableComponent'] * 10
