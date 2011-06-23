
module Shift
  class RDiscount < Interface

    def self.gem_dependencies
      %w{rdiscount}
    end

    def self.target_format
      'html'
    end

    def initialize(*switches)
      @switches = switches
    end
    
    def process(str)
      ::RDiscount.new(str, *@switches).to_html
    end

  end
end
