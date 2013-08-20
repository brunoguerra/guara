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
                          :user_id,
                          :contact,
                          :person,
                          :person_id,
                          :deal,
                          :scheduled,
                          :scheduled_id,
                          :group,
                          :group_id

          #constants
          ACCEPTED = 1
          DENIED = 2
          SCHEDULED = 3
          SCHEDULED_REALIZED = 4

          #Associations
          belongs_to :classified
          belongs_to :person
      		belongs_to :contact, class_name: "Guara::Contact"
          belongs_to :deal, class_name: "Guara::ActiveCrm::Scheduled::Deal"
          belongs_to :scheduled
          belongs_to :group

          #filter
          before_save :join_to_opened_deal_or_create
          before_save :ensure_scheduled

          validates_presence_of :result, :activity, :person, :contact

          validates_each :scheduled_at do |record, attr, value|
            record.errors.add attr, I18n.t('activerecord.errors.messages.less_than_of', :of => Date.today.to_s) if ((record.result==Contact::SCHEDULED) && ((Date.parse(value.to_s) < Date.today) || (value.to_s.empty?)))
          end

          def status
            return self.classified.nil? ? translate_scheduled_contact_result(self.result) : self.classified.name
          end

          def change_to_scheduled
            self.result = SCHEDULED 
          end

          def change_to_scheduled_realized
            self.result = SCHEDULED_REALIZED 
          end

          def self.results
            {
              :registered => 1,
              :participation_denied => 2,
              :scheduling => 3
            }
          end

          def contact_id=(contact_id)
            write_attribute(:contact_id, contact_id)
            write_attribute(:person_id, self.contact.customer.id)
          end

          def group=(group)
            unless group.nil?
              write_attribute(:group_id, group.id)
              write_attribute(:scheduled_id, group.scheduled.id)
            else
              write_attribute(:group_id, nil)
              write_attribute(:scheduled_id, nil)
            end
          end

          def join_to_opened_deal
            raise "Error, scheduled not exists" if self.deal.nil? && self.scheduled.nil?

            #already have deal
            unless self.deal.nil?
              self.scheduled = self.deal.scheduled if self.scheduled.nil?
              self.group = self.deal.group if self.group.nil?
              return self
            end

            #checks
            return RuntimeError.new("Contact without customer and scheduled cannot be valid...") unless (self.person && self.scheduled)

            self.deal = Guara::ActiveCrm::Scheduled::Deal.where(
              customer_id: self.person.id,
              scheduled_id: self.scheduled.id,
              closed: false,
            ).first
            return self
          end

          def join_to_opened_deal_or_create
            # join a deal
            if self.join_to_opened_deal.deal==nil
              self.deal = self.scheduled.initialize_deal(self.person, self.group)
              self.deal.save!
            end

            self
          end

          def ensure_scheduled
            pre_scheduleds = Contact.where({
              contact_id: contact.id,
              scheduled_id: scheduled.id,
              result: SCHEDULED
            })
            pre_scheduleds = pre_scheduleds.where("id <> ?", self.id) unless self.id.nil?

            pre_scheduleds.each do |d_contact|
              d_contact.update_attribute(:result, SCHEDULED_REALIZED)
            end
          end

    		end
      end
  	end
end
