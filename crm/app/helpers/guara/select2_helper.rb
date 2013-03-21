module Guara
	module Select2Helper

		def filter_multiselect param_search, param
		      return if (!param_search.include? param)
		      param_search[param].delete '' if (!param_search.nil?) && (param_search.include? param) && (param_search[param][0].to_s.empty?)
		      if (param_search.include? param) && 
		         (param_search[param].size==0)
		        param_search.delete param
		      end
		end


	end
end