
require 'shift'


module Shift

  # The Shift command line interface.
  #
  module CLI
    class << self

      def run!
        if ARGV.size == 0
          abort "Usage:   shift [file] [action] [type]\n" +
                "In pipe: shift - [type] [action]\n\n" +
                "Available types and actions:\n\n" +
                Shift.inspect_actions
        end

        if ARGV[0] != '-'
          puts Shift.read(*ARGV)
        else
          ARGV.shift
          ARGV << :echo if ARGV.empty?
          puts Shift[*ARGV].new.process(STDIN.read)
        end

      end

    end
  end
end
