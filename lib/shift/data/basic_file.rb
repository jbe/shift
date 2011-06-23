
require 'stringio'


module Shift

  # Scope containing the different format classes, in
  # which actions upon those formats are defined.
  #
  module Data

    # An abstract basic file, consisting of data and path.
    # Formats that are persistable to disk should inherit
    # from BasicFile.
    #
    # Data can be given as `String` or `IO`.
    # It can be "converted" betweed the two when needed.
    #
    class BasicFile

      # Files above FSIZE_THRESH will be opened as IO,
      # otherwise, they are opened as String.
      #
      FSIZE_THRESH = 2 ** 18 # = 1MB/4
      
      class << self

        def read(path)
          data = (File::Stat.new(path).size < FSIZE_THRESH) ?
            File.read(path) : File.new(path)
          new(data, path)
        end

        def concat(*paths)
          new('').cat(*paths)
        end
        alias :cat :concat

      end

      def initialize(src_data, path=nil)
        @data = {}
        self.data = src_data
        @path = case path
          when String then path
          when Symbol then 'no_name.' + path.to_s
          else path.to_s
        end
      end

      attr_accessor :path

      def data
        @data[String] || @data[IO]
      end

      def data_io
        @data[IO] ||= StringIO.new(@data[String])
      end

      def data_string
        @data[String] ||= begin
          d = @data[IO].read
          begin
            @data[IO].rewind if @data[IO].respond_to?(:rewind)
          rescue
            @data[IO] = nil
          end
          d
        end
      end
      alias :to_s :data_string

      # append a string
      def <<(data)
        data_string << data
        @data[IO] = nil
        self
      end
      alias :append :<<

      # read and append files
      def concat(*paths)
        paths.each {|p| self << File.read(p) }
        self
      end
      alias :cat :concat

      # write file to disk
      def write(path=nil)
        IO.copy_stream(data_io, path || @path || path_error)
        self
      end

      # initialize a duplicate of this file wrapper. used by
      # non-destructive modifying methods.
      def copy
        self.class.new(data, @path.dup)
      end

      # Modify data given a filter block. Optionally also change
      # file path, given options like:
      #
      #   :chomp  => '.gz'
      #   :append => '.new_ext'
      #   :rename => 'new_name' (keeps extension and dir intact)
      #   :move   => 'dir'
      #   :from   => 'dir'      (when moving relative to a dir)
      #
      def process(opts={})
        Shift.new(block_given? ? yield(data) : data,
                  process_path(opts))
      end
      alias :tranform :process

      def dir;      File.dirname(@path  || path_error); end
      def basename; File.basename(@path || path_error); end
      def extname;  File.extname(@path  || path_error); end
      def full_ext
        idx = basename.index('.')
        idx ? basename[idx..-1] : ''
      end

      def rename!(new_name, keep_ext=false)
        self
      end

      def move(*args);            copy.move!(*args); end
      def rename(*args);          copy.rename!(*args); end

      # actions
      #
      Lazy = LazyLoad.scope do
        map :Zlib, 'zlib'
      end

      # gzips the file through a pipe using Zlib from stdlib
      #
      def gzip
        read_io, write_io = IO.pipe
        gz = Lazy::Zlib::GzipWriter.new(write_io)
        gz.write(data_string)
        gz.close
        process(:append => '.gz') { read_io }
      end
    
    private

      def data=(data)
        @data.clear
        case data
        when String then @data[String] = data.dup
        when IO     then @data[IO] = data
        else raise Shift::DataError, "unfamiliar #{data.inspect}"
        end
      end

      def process_path(opts)
        p = path.dup
        if opts[:rename]
          p = File.join(dir, opts[:rename]) << full_ext
        end
        p.chomp!(opts[:chomp]) if opts[:chomp]
        p << opts[:append]     if opts[:append]
        if opts[:move]
          current = File.expand_path(File.dirname(p))
          from = opts[:from] ? File.expand_path(opts[:from]) :
                               current
          frags = [opts[:move]]
          if (current[0, from.length] == from)
            frags << current[from.length..-1]
          end
          frags << File.basename(p)
          p = File.join(*frags)
        end
        p
      end


      # change the file path to be within target_dir
      def move_path(opts)
        path_ary = [opts[:move]]
        if opts[:from]
          full_from = File.expand_path(opts[:from])
          full_current = File.expand_path(dir)
        end
        path_ary << basename
        File.join(*path_ary)
      end
    
      def path_error
        raise(Shift::PathError, 'missing file name')
      end

    end
  end
end

