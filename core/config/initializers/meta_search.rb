

MetaSearch::Where.add :between, :btw,
  {
	 	:predicate => :in,
	  	:types => [:integer, :float, :decimal, :date, :datetime, :timestamp, :time],
	  	:formatter => Proc.new {|param| Range.new(param.first, param.last)},
	  	:validator => Proc.new {|param|
	    	param.is_a?(Array) && !(param[0].blank? || param[1].blank?) }
	}