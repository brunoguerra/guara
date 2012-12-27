module Guara
  module Core
    class Environment

      attr_accessor :modules
      attr_accessor :partials
      
      def initialize()
        @partials = Guara::Core::Partials.new
      end
      
    end
  end
end