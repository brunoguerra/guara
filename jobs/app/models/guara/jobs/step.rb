require File.expand_path("../../jobs", __FILE__) if Rails.env.development?

class Guara::Jobs::Step < ActiveRecord::Base
  	attr_accessible :name, :next, :level, :custom_process_id

  	has_many   :step_attrs, :dependent => :destroy
  	has_many   :custom_processes, :dependent => :destroy
  	has_many   :step_instance_attrs, :dependent => :destroy

  	belongs_to :parent, class_name: "Step", foreign_key: "next"
	belongs_to :custom_process

	def step_attrs_resume
		self.step_attrs.where(:resume=> true).order(:position)
	end

	def step_attrs_vals(process_instance_id)
		self.step_instance_attrs.where(:process_instance_id=> process_instance_id)
	end
end
