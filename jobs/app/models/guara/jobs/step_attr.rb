require File.expand_path("../../jobs", __FILE__) if Rails.env.development?

class Guara::Jobs::StepAttr < ActiveRecord::Base
  attr_accessible :title, :column, :required, :widget, :group, :type_field, 
  :position, :step_id, :options, :resume
  
  attr_writer :html_options, :select_opts

  belongs_to :step
  has_many :step_instance_attrs, :dependent => :destroy
  
  def html_options
    @html_options || {}
  end

  def select_opts
    @select_opts || []
  end
  
end
