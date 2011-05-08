
class UnavailableComponent < Shift::Identity
  
  INSTRUCTIONS = 'meditate.'

  def self.available?
    false
  end

end

class NullComponent < Shift::Identity

  def self.available?
    true
  end

  def process(str)
    ''
  end

end

Shift::MAPPINGS['unavailable'] = ['UnavailableComponent'] * 10

Shift::MAPPINGS['null']             = %w{NullComponent}
Shift::MAPPINGS['bingo.bongo']  = %w{NullComponent}

Shift::MAPPINGS['prioritized'] = %w{UnavailableComponent
                          NullComponent Identity}







