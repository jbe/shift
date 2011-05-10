

module Shift
  # The shift command line interface.
  module CLI
    class << self

      def run!
        if ARGV.empty?
          puts "Usage:    shift [file] [action]\n" +
               "In pipe:  shift [type] [action]"
        else
          require 'shift'

          puts File.exists?(path) ?
                Shift.read(*ARGV) :
                Shift[ARGV[0]].process(STDIN.read)
        end
      end

    end
  end
end
