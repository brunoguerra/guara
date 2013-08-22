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

      default_scope order('created_at DESC')

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

    end
  end
end