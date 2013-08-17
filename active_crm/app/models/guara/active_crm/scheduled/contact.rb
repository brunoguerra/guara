module Guara
	module ActiveCrm
      class Scheduled
    		class Contact < ActiveRecord::Base
          belongs_to :classified
          belongs_to :person
      		belongs_to :contact, class_name: "Guara::Contact"
          belongs_to :deal, class_name: "Guara::ActiveCrm::Scheduled::Deal"

          attr_accessor :scheduled, :group

          before_save :join_to_opened_deal_or_create
        
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
                          :deal

          validates_presence_of :result, :activity, :person, :contact

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

          def contact_id=(contact_id)
            write_attribute(:contact_id, contact_id)
            write_attribute(:person_id, self.contact.customer.id)
          end

          def group=(group)
            @group = group
            @scheduled = @group.scheduled
          end

          def self.results_translated
            {
              1 => I18n.t("active_crm.results_translated.registered"),
              2 => I18n.t("active_crm.results_translated.participation_denied"),
              3 => I18n.t("active_crm.results_translated.scheduling")
            }
          end

          def join_to_opened_deal(scheduled=nil)
            check_scheduled(scheduled)

            #already have deal
            return self unless @deal.nil?

            #checks
            return RuntimeError.new("Contact without customer and scheduled cannot be valid...") unless (self.person && @scheduled)

            self.deal = Guara::ActiveCrm::Scheduled::Deal.where(
              customer_id: self.person.id,
              scheduled_id: @scheduled.id,
              closed: false,
            ).first
            return self
          end

          def join_to_opened_deal_or_create(scheduled=nil, group=nil)
            check_scheduled(scheduled)
            @group ||= group
            # join a deal
            if self.join_to_opened_deal(@scheduled).deal==nil
              self.deal = @scheduled.initialize_deal(self.person, group)
              self.deal.save!
            end

            self
          end

          def check_scheduled(scheduled)
            raise "Error, scheduled not exists" if @deal.nil? && @scheduled.nil? && scheduled.nil?
            @scheduled = scheduled if @scheduled.nil?
          end

    		end
      end
  	end
end
