module Guara
  #esta linha me fez perder horas debugando
  #include Rails.application.routes.url_helpers

  class Task < ActiveRecord::Base
  
    #helper_method :name_or_empty, :current_user
  
    include StringHelper
  
    attr_accessible :name, :interested, :user, :contact, :status, :resolution, :due_time, :finish_time, :notes,
                    :description, :type, :assigned, 
                    :type_id, :contact_id, :assigned_id, :feedbacks # to form 

    belongs_to :interested, :polymorphic => true
    belongs_to :contact, :polymorphic => true
    belongs_to :status, class_name: "SystemTaskStatus"
    belongs_to :resolution, class_name: "SystemTaskResolution"
    belongs_to :user
    belongs_to :type, class_name: "TaskType"
    belongs_to :assigned, class_name: "User"
  
    has_many :feedbacks, class_name: "TaskFeedback"

  
    #=========================== VALIDATE <------------------------------------------------
  
    VALID_NAME_REGEX = /\A(.*[A-z0-9.,;\'\"\-\/]{3,}.*)+\z/i
  
    validates :name, :presence => true, length: { maximum: 150 }, format: { with: VALID_NAME_REGEX }
    validate :valid_status?
    validates_presence_of :status, :notes, :user, :due_time
  
    default_scope order: "due_time DESC"
  
    public
  
      def due_critical_level
      
        return 0 if done? || due_time.nil?
      
        if (due_time>Time.now)
          if (((due_time-Time.now)/1.day).round>Guara::Crm::TASKS_DUE_CRITICAL_DAYS_REMAINING)
            1
          else
            2
          end
        else
            3
        end
      end
    
      def done?
        self.status == SystemTaskStatus.CLOSED
      end
    
      def done
        self.status = SystemTaskStatus.CLOSED
        self.finish_time = Time.now
      end
  
    private
  
      def valid_status?
        if (((self.status == SystemTaskStatus.CLOSED) and (self.resolution == nil)) or
            ((self.status == SystemTaskStatus.OPENED) and (self.resolution != nil))) then
          errors.add(:status, I18n.t("tasks.errors.not_valid_status_and_resolution", status: name_or_empty(self.status),
                      resolution: name_or_empty(self.resolution)))
          false
        else  
          true
        end
      
      end
  
  end
end