

module Shift

  # The Shift command line interface.
  #
  module CLI
    class << self

      def run!
        unless [1..3].include(ARGV.size)
          abort "Usage:    shift [file] [action] [type]\n" +
                "In pipe:  shift - [type] [action]\n\n" +
                "Available types and actions:\n\n" +
                Shift.inspect_actions
        end

        require 'shift'

        if ARGV[0] != '-'
          puts Shift.read(*ARGV)
        else
          ARGV.shift
          ARGV << :echo if ARGV.empty?
          puts Shift[*ARGV].process(STDIN.read)
        end

        end
      end

    end
  end
end
