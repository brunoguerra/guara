module Guara
	module ActiveCrm
      class Scheduled
    		class Contact < ActiveRecord::Base
          include ScheduledContactsHelper

          attr_accessible :activity,
                          :result,
                          :scheduled_at,
                          :contact_id, 
                          :classified_id,
                          :deal_id, 
                          :deal,
                          :user,
                          :user_id,
                          :contact,
                          :contact_id

          #constants
          ##negative
          NOT_CONTACTED = -1
          NOT_CONTACTED_REALIZED = -4
          ##positive
          ACCEPTED = 1
          DENIED = 2
          SCHEDULED = 3
          SCHEDULED_REALIZED = 4

          #Associations
          belongs_to :classified
      		belongs_to :contact, class_name: "Guara::Contact"
          belongs_to :deal, class_name: "Guara::ActiveCrm::Scheduled::Deal"
          belongs_to :user

          validates_presence_of :result, :activity, :deal, :contact

          validates_each :scheduled_at do |record, attr, value|
            if (
                ((record.result == Contact::SCHEDULED) || (record.result == Contact::NOT_CONTACTED)) && 
                ((Date.parse(value.to_s) < Date.today) || (value.to_s.empty?))
            )
              record.errors.add attr, I18n.t('activerecord.errors.messages.less_than_of', :of => Date.today.to_s) 
            end
          end

          before_save :ensure_scheduled

          def status
            return self.classified.nil? ? translate_scheduled_contact_result(self.result) : self.classified.name
          end

          def change_to_scheduled
            self.result = SCHEDULED 
          end

          def change_to_scheduled_realized
            self.result = SCHEDULED_REALIZED 
          end

          def change_to_not_contacted
            self.result = NOT_CONTACTED
          end

          def change_to_not_contacted_realized
            self.result = NOT_CONTACTED_REALIZED
          end

          def self.results
            {
              :not_contacted => -1,
              :registered => 1,
              :participation_denied => 2,
              :scheduling => 3,
              :scheduling_realized => 4
            }
          end

          def contact_id=(contact_id)
            write_attribute(:contact_id, contact_id)
          end

          def ensure_scheduled
            pre_scheduleds = Contact.joins(:deal).where({
              contact_id: contact.id,
              Scheduled::Deal.table_name => { scheduled_id: self.deal.scheduled.id },
              result: [SCHEDULED, NOT_CONTACTED]
            })
            pre_scheduleds = pre_scheduleds.where("#{Scheduled::Contact.table_name}.id <> ?", self.id) unless self.id.nil?

            pre_scheduleds.each do |p_contact|
              d_contact = Scheduled::Contact.find p_contact.id
              result = d_contact.result == SCHEDULED ? SCHEDULED_REALIZED : NOT_CONTACTED_REALIZED
              d_contact.update_attribute(:result, result)
            end
          end

    		end
      end
  	end
end
