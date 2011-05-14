module Shift
  class Redcarpet < Interface

    def self.gem_dependencies
      %w{redcarpet}
    end

    def self.target_format
      'html'
    end

    def initialize(*switches)
      @switches = switches
    end
    
    def process(str)
      ::Redcarpet.new(str, *@switches).to_html
    end

  end
  RedCarpet = Redcarpet
end
