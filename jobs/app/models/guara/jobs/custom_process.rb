require File.expand_path("../../jobs", __FILE__) if Rails.env.development?

class Guara::Jobs::CustomProcess < ActiveRecord::Base
	attr_accessible :name, :business_id, :enabled, :step_init

	has_many   :steps, :dependent => :destroy
	has_many   :process_instances, :dependent => :destroy
	belongs_to :business
	belongs_to :step, foreign_key: "step_init"

end
