
module Shift
  class RDiscount < Identity

    def self.gem_dependencies
      %w{rdiscount}
    end

    def initialize(*switches)
      @switches = switches
    end
    
    def process_plain(str)
      ::RDiscount.new(str, *@switches).to_html
    end

  end
end
