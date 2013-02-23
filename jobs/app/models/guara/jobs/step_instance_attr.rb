require File.expand_path("../../jobs", __FILE__) if Rails.env.development?

class Guara::Jobs::StepInstanceAttr < ActiveRecord::Base
  attr_accessible :step_attr_id, :process_instance_id, :step_id, :value

  belongs_to :step
  belongs_to :step_attr
  belongs_to :process_instance
  has_many :step_instance_attr_multis, :dependent => :destroy

end
