module Guara
	module ActiveCrm
      class Scheduled
    		class Contact < ActiveRecord::Base
          belongs_to :classified
          belongs_to :customer, class_name: "Guara::Person"
      		belongs_to :contact, class_name: "Guara::Contact"
          belongs_to :deal, class_name: "Guara::ActiveCrm::Scheduled::Deal"
        
          attr_accessible :activity,
                          :result,
                          :scheduled,
                          :contact_id, 
                          :classified_id,
                          :deal_id, 
                          :user_id,
                          :contact,
                          :customer,
                          :deal

          validates_presence_of :result, :activity, :deal, :customer, :contact

          validates_each :scheduled do |record, attr, value|
            record.errors.add attr, I18n.t('activerecord.errors.messages.less_than_of', :of => Date.today.to_s) if ((record.result==ActiveCrm::SCHEDULED) && (Date.parse(value.to_s) < Date.today))
          end

          def status
            return self.classified.nil? ? Contact.results_translated()[self.result] : self.classified.name
          end

          ACCEPTED = 1
          DENIED = 2
          SCHEDULED = 3

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

          def join_to_opened_deal(scheduled)
            return RuntimeError.new("Contact without customer and scheduled cant be valid...") unless (self.customer && scheduled)
            self.deal = Guara::ActiveCrm::Scheduled::Deal.where(
              customer_id: self.customer.id,
              scheduled_id: scheduled.id,
              closed: false,
            ).first
            return self
          end

          def join_to_opened_deal_or_create(scheduled, group=nil)
            if self.join_to_opened_deal(scheduled).deal==nil
              self.deal = scheduled.initialize_deal(self.customer, group)
              self.deal.save!
            end

            self
          end

    		end
      end
  	end
end
