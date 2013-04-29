require File.expand_path("../../jobs", __FILE__) if Rails.env.development?

class Guara::Jobs::ProcessInstance < ActiveRecord::Base
  attr_accessible :date_finish, :date_start, :process_id, :state, :user_using_process, :finished, :status

  belongs_to :custom_process, foreign_key: "process_id"
  belongs_to :step, foreign_key: "state"
  #@deprecated Utilizar o acesso por step
  has_many :step_instance_attrs, :dependent => :destroy
  
  after_save :after_save
  
  def process_id=(process_id)
    write_attribute(:process_id, process_id)
    self.custom_process.call_hook_initialize(self)
  end
  
  def step_init
  	self.custom_process.step
  end

  def steps_connecteds(id)
      @steps.each do |s|
        if s.id == id
          @steps_conn << s
          steps_connecteds(s.next) if !s.next.nil?
        end
      end
  end

  def steps_order
  	@steps = self.custom_process.steps.order(:level)

    @steps_conn = []
    self.steps_connecteds(self.custom_process.step_init)
    @steps = @steps_conn
  end

  def steps_previous_current
    self.custom_process.steps.where("level <= ?", self.step.level).order('level DESC')
  end
  
  def after_save
    if (self.respond_to?(:hook_after_save))
      self.hook_after_save()
    end
  end

  def self.status 
    {
      0 => :open,
      1 => :suspended,
      2 => :reopened_replacement,
      3 => :reopened_others,
      4 => :closed_partial,
      5 => :total_closed
    }
  end

  def self.status_translated
    {
      0 => I18n.t("jobs.process_instance.status.open"),
      1 => I18n.t("jobs.process_instance.status.suspended"),
      2 => I18n.t("jobs.process_instance.status.reopened_replacement"),
      3 => I18n.t("jobs.process_instance.status.reopened_others"),
      4 => I18n.t("jobs.process_instance.status.closed_partial"),
      5 => I18n.t("jobs.process_instance.status.total_closed")
    }
  end


end
