module Guara
  module ActiveCrm
  	module ScheduledContactsHelper

  		def prepare_span_status(record)
  			return "<span class='#{get_class_color(record)}'>#{record.status}</span>"
  		end

  		private
  		def get_class_color(record)
  			results = Guara::ActiveCrm::Scheduled::Contact.results
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

      def translate_scheduled_contact_result(result)
        
        { 
          1 => I18n.t("scheduleds.contacts.result.accepted"),
          2 => I18n.t("scheduleds.contacts.result.denied"),
          3 => I18n.t("scheduleds.contacts.result.scheduled")
        }[result]
      end
      

      def scheduled_contacts_ignored_ids
        (session[:ignored_customers].nil? ? [] : session[:ignored_customers]).join(',')
      end
  	end
  end
end