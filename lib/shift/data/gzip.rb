
module Shift
  module Data
    class Gzip < BasicFile

      def inflate
        gz = Lazy::Zlib::GzipReader.new(data_io)
        process(:chomp => '.gz') { gz.read }
      end
      alias :unzip   :inflate
      alias :unpack  :inflate
      alias :extract :inflate

    end
  end
end
