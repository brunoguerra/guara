module Guara
  module ActiveCrm
  	module ScheculedContactsHelper

  		def prepare_span_status(record)
  			return raw("<span class='#{get_class_color(record)}'>#{record.status}</span>")
  		end

  		private
  		def get_class_color(record)
  			results = Guara::ActiveCrm::ScheduledContact.results
  			if results[:registered] == record.result
  				class_color = 'label label-success'
  			elsif results[:scheduling] == record.result
  				class_color = 'label label-warning'
  			elsif results[:participation_denied] == record.result
  				class_color = 'label label-important'
  			else
  				class_color = 'label'
  			end

  			return class_color
  		end
  	end
  end
end