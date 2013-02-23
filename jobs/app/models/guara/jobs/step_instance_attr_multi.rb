require File.expand_path("../../jobs", __FILE__) if Rails.env.development?

class Guara::Jobs::StepInstanceAttrMulti < ActiveRecord::Base
  attr_accessible :step_instance_attr_id, :value

  belongs_to :step_instance_attr

  validates :value, :presence => true
end
