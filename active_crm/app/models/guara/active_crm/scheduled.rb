module Guara
  module ActiveCrm
    class Scheduled < ActiveRecord::Base
      attr_accessible :date_finish,
                      :date_start, 
                      :subject, 
                      :user_id, 
                      :task_type_id, 
                      :task_type, 
                      :status

      attr_accessor :name

    
      belongs_to :task_type, class_name: "Guara::TaskType"
      belongs_to :user, class_name: "Guara::User"

      has_many :groups, :class_name => "Guara::ActiveCrm::Scheduled::Group"
      has_many :deals, :through => :groups
      has_many :contacts, :through => :deals

      has_many :positives, through: :deals, source: :contacts,  conditions: " result >=0 "
      has_many :negatives, through: :deals, source: :contacts,  conditions: " result < 0 "
      has_many :contacts, through: :deals, source: :contacts

      has_many :accepteds, through: :deals, source: :contacts, conditions: { result: Scheduled::Contact::ACCEPTED }
      has_many :denieds, through: :deals, source: :contacts, conditions: { result: Scheduled::Contact::DENIED }
      has_many :interested, through: :deals, source: :contacts, conditions: { result: [Scheduled::Contact::INTERESTED, Scheduled::Contact::INTERESTED_CHANGE] }
      has_many :interesteds_change, through: :deals, source: :contacts, conditions: { result: [Scheduled::Contact::INTERESTED_CHANGE] }
      has_many :denieds, through: :deals, source: :contacts, conditions: { result: Scheduled::Contact::DENIED }

      default_scope order('created_at DESC')

      validates_presence_of :date_start, :user_id

      def name
        "#{self.date_start.strftime("%d/%m/%Y")} - #{self.user.name} - #{self.task_type.name}"
      end

      def self.status 
        {
          0 => :open,
            1 => :completed
        }
      end

      def self.translate_status
        {
          0 => I18n.t("scheduleds.status.open"),
            1 => I18n.t("scheduleds.status.completed")
        }
      end

      def initialize_deal(customer, group=nil)
        ActiveCrm::Scheduled::Deal::new(
          customer: customer,
          group: group,
          scheduled: self,
          date_start: Time.now,
          closed: false,
        ) 
      end

      def denieds_totals 
        Scheduled::Contact.joins({ :deal => :scheduled}, :classified).select("count(#{Scheduled::Contact.table_name}.id) total, #{Scheduled::Classified.table_name}.id classified_id, #{Scheduled::Classified.table_name}.name").where("#{Scheduled::Deal.table_name}" => {scheduled_id: self.id}, result: Scheduled::Contact::DENIED).group("#{Scheduled::Classified.table_name}.name", "#{Scheduled::Classified.table_name}.id")
      end

    end
  end
end