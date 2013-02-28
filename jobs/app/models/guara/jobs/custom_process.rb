require File.expand_path("../../jobs", __FILE__) if Rails.env.development?

class Guara::Jobs::CustomProcess < ActiveRecord::Base
  attr_accessible :name, :business_id, :enabled, :step_init, :hook_instanciate

  has_many   :steps, :dependent => :destroy
  has_many   :process_instances, :dependent => :destroy
  belongs_to :business
  belongs_to :step, foreign_key: "step_init"
  
  
  
  def call_hook_initialize(object)
    if !self.hook_instanciate.nil?
      self.hook_instanciate.split(" ").each do |hook_s|
        class_hook = eval hook_s
        class_hook.new(object)
      end
    end
  end

end
