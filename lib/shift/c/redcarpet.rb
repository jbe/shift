module Shift
  class Redcarpet < Identity

    def self.gem_dependencies
      %w{redcarpet}
    end

    def initialize(*switches)
      @switches = switches
    end
    
    def process_plain(str)
      ::Redcarpet.new(str, *@switches).to_html
    end

  end
  RedCarpet = Redcarpet
end
