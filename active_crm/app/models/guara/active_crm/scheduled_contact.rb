module Guara
	module ActiveCrm
  		class ScheduledContact < ActiveRecord::Base
    		belongs_to :contact
    		belongs_to :classified, class_name: "Guara::ActiveCrm::ScheduledClassified", foreign_key: :classified_id
    		belongs_to :schedule, class_name: "Guara::ActiveCrm::Scheduled", foreign_key: :scheduled_id
    	
    		attr_accessible :activity, :result, :scheduled, :scheduled_id, :contact_id, 
    		:classified_id

        def status
          return self.classified.nil? ? self.results_translated()[self.result] : self.classified.name
        end

        def self.results
          {
            :registered => 1,
            :participation_denied => 2,
            :scheduling => 3
          }
        end

        def self.results_translated
          {
            1 => I18n.t("active_crm.results_translated.registered"),
            2 => I18n.t("active_crm.results_translated.participation_denied"),
            3 => I18n.t("active_crm.results_translated.scheduling")
          }
        end

  		end
  	end
end
