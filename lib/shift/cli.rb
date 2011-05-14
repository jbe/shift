
require 'shift'


module Shift

  # The `shifter` command line interface.
  #
  class CLI

    USAGE = "Usage:   shifter <file> [action] [format]\n" +
            "In pipe: shifter - format [action]\n\n" +
            "Available formats and actions:\n\n" +
            Shift.inspect_actions

    def self.new
      begin
        super(*ARGV)
      rescue ArgumentError
        abort USAGE
      end
    end
    
    def initialize(path, a=nil, b=nil)
      @path = path
      @format, @action = stdin? ? [a,b] : [b,a]
      @format ||= :echo
      @action ||= :default
    end

    def stdin?
      @path == '-'
    end

    def data
      stdin? ? STDIN.read : File.read(@path)
    end

    def run!
      puts Shift(data, @format).process(@action)
    end
  end
end
