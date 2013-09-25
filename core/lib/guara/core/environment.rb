module Guara
  module Core
    class Environment

      HOME_PATH = lambda { "guara/static_pages#home" }

      attr_accessor :modules
      attr_accessor :partials
      
      def initialize()
        @partials = Guara::Core::Partials.new
        @modules = {}
      end

      def module(_module, _value)
        @modules[_module] = _value
      end

      def update_module(_module, _value)
        @modules[_module] = _value
      end

      def routes_home_path(local=false)
        res = HOME_PATH.call
        res.gsub(/guara\//) if local
        res
      end
      
    end
  end
end