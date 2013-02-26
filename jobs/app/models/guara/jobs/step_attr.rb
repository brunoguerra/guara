require File.expand_path("../../jobs", __FILE__) if Rails.env.development?

class Guara::Jobs::StepAttr < ActiveRecord::Base
  attr_accessible :label, :column, :required, :widget, :type_field, 
  :position, :step_id, :guidelines, :options, :resume

  belongs_to :step
  has_many :step_instance_attrs, :dependent => :destroy
end
