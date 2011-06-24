
module Shift
  module Data
    class CoffeeScript < BasicFile

      Lazy.const(:CoffeeScript, 'coffee-script')
      
      def compile(*params)
        process(:chomp => '.coffee', :append => '.js') do
          Lazy::CoffeeScript.compile(data, *params)
        end
      end

      alias :render :compile

    end
  end
end
