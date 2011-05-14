module Shift
  class ZlibReader < Interface

    def self.keep_extension?
      false
    end

    def self.target_format
      false
    end

    def initialize
      require 'zlib'
      require 'stringio'
    end
    
    def process(data)
      gz = Zlib::GzipReader.new(StringIO.new(data))
      gz.read
    end

  end
end
