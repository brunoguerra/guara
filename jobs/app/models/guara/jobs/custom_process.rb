require File.expand_path("../../jobs", __FILE__) if Rails.env.development?

class Guara::Jobs::CustomProcess < ActiveRecord::Base
  attr_accessible :name, :business_id, :enabled, :step_init, :hook_instanciate, :released, :source_id

  has_many   :steps, :dependent => :destroy
  has_many   :process_instances, :dependent => :destroy
  has_many   :custom_processes, foreign_key: "source_id"

  belongs_to :business
  belongs_to :step, foreign_key: "step_init"
  
  def has_hook?
    !hook_instanciate.to_s.empty?
  end
  
  def hook
    if !self.hook_instanciate.to_s.empty?
      self.hook_instanciate.constantize
    else
      nil
    end
  end
  
  def call_hook_initialize(object)
    if !self.hook_instanciate.nil?
      self.hook_instanciate.split(" ").each do |hook_s|
        class_hook = eval hook_s
        class_hook.new(object)
      end
    end
  end

  def get_released
    released = self.custom_processes.where(:released => true).first
    released = self if released.nil?
    return released
  end

end
