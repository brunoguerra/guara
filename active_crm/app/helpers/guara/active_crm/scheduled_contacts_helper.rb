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
  			elsif results[:scheduled] == record.result
  				class_color = 'label label-warning'
  			elsif results[:denied] == record.result
  				class_color = 'label label-important'
        elsif results[:interested] == record.result
          class_color = 'label label-info'
  			else
  				class_color = 'label'
  			end

  			return class_color
  		end

      def translate_scheduled_contact_result(result)
        
        { 
          -25 => I18n.t("scheduleds.contacts.result.not_contacted"),
          -26 => I18n.t("scheduleds.contacts.result.not_contacted_realized"),

          1 => I18n.t("scheduleds.contacts.result.accepted"),
          2 => I18n.t("scheduleds.contacts.result.denied"),
          3 => I18n.t("scheduleds.contacts.result.interested"),

          11 => I18n.t("scheduleds.contacts.result.accepted_change"),
          12 => I18n.t("scheduleds.contacts.result.denied_change"),
          13 => I18n.t("scheduleds.contacts.result.interested_change"),

          25 => I18n.t("scheduleds.contacts.result.scheduled"),
          26 => I18n.t("scheduleds.contacts.result.scheduled_realized"),
        }[result]
      end
      

      def scheduled_contacts_ignored_ids
        (session[:ignored_customers].nil? ? [] : session[:ignored_customers]).join(',')
      end
  	end
  end
end