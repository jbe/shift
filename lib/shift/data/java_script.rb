
module Shift
  module Data
    class JavaScript < BasicFile

      Libs = LazyLoad.new do

        const(:Uglifier, 'uglifier')
        const(:ClosureCompiler) do
          require 'closure-compiler'
          Closure::Compiler
        end
        const(:YUICompressor) do
          require 'yui/compressor'
          YUI::JavaScriptCompressor
        end

        wrap(:YUICompressor) do
          def new(*args); YUIWrapper.new(super(*args)); end

          class YUIWrapper < LazyLoad::Wrapper
            def compile(*args); compress(*args); end
          end
        end
      
        group(:minify, :Uglifier, :ClosureCompiler, :YUICompressor)
      end
      
      def minify(opts={})
        gem = opts.delete(:lib)
        process(:chomp => '.js', :append => '.min.js') do
          Libs[gem || :minify].new(opts).compile(data_string)
        end
      end

      def uglify(opts={})
        minify(opts.merge({:lib => :Uglifier}))
      end

      def closure_compile(opts={})
        minify(opts.merge({:lib => :ClosureCompiler}))
      end

      def yui_compress(opts={})
        minify(opts.merge({:lib => :YUICompressor}))
      end

      alias :compile  :minify
      alias :compress :minify
      alias :pack     :minify
      alias :minimize :minify

    end
  end
end
