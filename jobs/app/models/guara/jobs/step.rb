require File.expand_path("../../jobs", __FILE__) if Rails.env.development?

class Guara::Jobs::Step < ActiveRecord::Base
  	attr_accessible :name, :next, :level, :custom_process_id

    #@deprecated
  	has_many   :step_attrs, :dependent => :destroy
  	#nome que deve ficar
  	has_many   :attrs, :dependent => :destroy, class_name: "Guara::Jobs::StepAttr"
  	
  	#@deprecated
  	has_many   :custom_processes, :dependent => :destroy
  	
  	has_many   :step_instance_attrs, :dependent => :destroy

  	belongs_to :parent, class_name: "Step", foreign_key: "next"
	  
	  #@deprecated
	  belongs_to :custom_process
	  #deve ficar
	  belongs_to :process, class_name: "Guara::Jobs::CustomProcess"

	def step_attrs_resume
		self.step_attrs.where(:resume=> true).order(:position)
	end

	def step_attrs_vals
		self.step_instance_attrs.joins(:step_attr).where("guara_jobs_step_attrs.resume", true)
	end
end
