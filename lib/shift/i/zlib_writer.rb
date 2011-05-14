module Shift
  class ZlibWriter < Interface

    def self.keep_extension?
      true
    end

    def self.target_format
      'gz'
    end

    def initialize
      require 'zlib'
      require 'stringio'
    end
    
    def process(str)
      StringIO.open('', 'w') do |io|
        gz = Zlib::GzipWriter.new(io)
        gz.write(str)
        gz.close
        io.string
      end
    end

  end
end
