require File.expand_path("../../jobs", __FILE__) if Rails.env.development?

class Guara::Jobs::StepInstance < ActiveRecord::Base
  attr_accessible :process_instance_id

  belongs_to :process_instance
  #has_many :step_instance_attrs
  
end
