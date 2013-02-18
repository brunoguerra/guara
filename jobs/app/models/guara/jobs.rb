module Guara
	module Jobs
		def self.table_name_prefix
		  'guara_jobs_'
		end
	end

	Person.class_eval do
		has_one :professional, class_name: "Guara::Jobs::Professional"
	end
end



puts Guara::Jobs.table_name_prefix+("%s:%d" % [__FILE__, __LINE__])
