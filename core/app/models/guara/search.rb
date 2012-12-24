module Guara
  class Search
    def initialize(params={})
      @params = Hash.new.merge(params['search'] || {})
    end 
 
    def method_missing(method_sym,*args)
      case method_sym.to_s
      when /^\[\]=?$/
        @params.send(method_sym,*args)
      when /^(.*)=$/
        @params.update($1,*args)
      else
        @params[method_sym.to_s]
      end
    end
 
  end
end