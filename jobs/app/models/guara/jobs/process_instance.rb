require File.expand_path("../../jobs", __FILE__) if Rails.env.development?

class Guara::Jobs::ProcessInstance < ActiveRecord::Base
  attr_accessible :date_finish, :date_start, :process_id, :state, :user_using_process

  belongs_to :custom_process, foreign_key: "process_id"
  belongs_to :step, foreign_key: "state"
  has_many :step_instance_attrs, :dependent => :destroy

  def step_init
  	self.custom_process.step
  end

  def steps_order
  	self.custom_process.steps.order(:level)
  end

  def steps_previous_current
    self.custom_process.steps.where("level <= ?", self.step.level).order('level DESC')
  end
end
