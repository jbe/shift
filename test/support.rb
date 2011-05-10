
class UnavailableComponent < Shift::Identity
  
  def self.instructions
    'meditate'
  end

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

module Shift
  map(:unavailable,   ['UnavailableComponent'] * 10)
  map(:null,          %w{NullComponent})
  map('bingo.bongo',
    :default => %w{NullComponent},
    :custom  => %w{Identity}
    )
  map(:prioritized,   %w{UnavailableComponent NullComponent Identity})
end
