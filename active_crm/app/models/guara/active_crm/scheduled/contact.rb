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
          NOT_CONTACTED          = -25
          NOT_CONTACTED_REALIZED = -26

          ##positive
          ACCEPTED    = 1
          DENIED      = 2
          INTERESTED  = 3

          #positive change mind
          ACCEPTED_CHANGE    = 11
          DENIED_CHANGE      = 12
          INTERESTED_CHANGE  = 13

          #scheduled
          SCHEDULED          = 25
          SCHEDULED_REALIZED = 26

          SCHEDULED_RESULTS = [
                                INTERESTED,
                                SCHEDULED,
                                NOT_CONTACTED
                              ]

          RESULTS = [           
                      NOT_CONTACTED,
                      NOT_CONTACTED_REALIZED,
                      ##positive
                      ACCEPTED,
                      DENIED,
                      INTERESTED,
                      #positive change mind
                      ACCEPTED_CHANGE,
                      DENIED_CHANGE,
                      INTERESTED_CHANGE,
                      #scheduled
                      SCHEDULED,
                      SCHEDULED_REALIZED
                    ]


          #Associations
          belongs_to :classified
      		belongs_to :contact, class_name: "Guara::Contact"
          belongs_to :deal, class_name: "Guara::ActiveCrm::Scheduled::Deal"
          belongs_to :user

          validates_presence_of :result, :activity, :deal, :contact

          validates_each :scheduled_at do |record, attr, value|
            if (
                ((record.result == Contact::SCHEDULED) || (record.result == Contact::NOT_CONTACTED) || (record.result == Contact::INTERESTED)) && 
                ((Date.parse(value.to_s) < Date.today) || (value.to_s.empty?))
            )
              record.errors.add attr, I18n.t('activerecord.errors.messages.less_than_of', :of => Date.today.to_s) 
            end
          end

          before_save :ensure_scheduled
          after_save :ensure_verdict

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

          def change_to_denied
            self.result = DENIED
          end

          def change_to_accepted
            self.result = ACCEPTED
          end

          def self.results
            {
              :not_contacted => -25,
              :not_contacted_realized => -26,
              :registered => 1,
              :denied => 2,
              :interested => 3,
              :scheduled => 25,
              :scheduled_realized => 26
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

          def ensure_verdict
            verdicts = [ACCEPTED, DENIED, INTERESTED]
            return true unless verdicts.include? self.result
            pre_scheduleds = Contact.joins(:deal).where({
              contact_id: contact.id,
              Scheduled::Deal.table_name => { scheduled_id: self.deal.scheduled.id },
              result: verdicts
            })
            pre_scheduleds = pre_scheduleds.where("#{Scheduled::Contact.table_name}.id <> ?", self.id) unless self.id.nil?

            puts pre_scheduleds.to_sql
            pre_scheduleds.each do |p_contact|
              d_contact = Scheduled::Contact.find p_contact.id

              case d_contact.result
              when ACCEPTED
                result = ACCEPTED_CHANGE
              when DENIED
                result = DENIED_CHANGE
              when INTERESTED
                result = INTERESTED_CHANGE
              end
              
              d_contact.update_attribute(:result, result)
            end
          end

    		end
      end
  	end
end
