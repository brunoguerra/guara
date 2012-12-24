module Guara

  class UserAbility < ActiveRecord::Base
    attr_accessible :skilled, :ability, :module
  
    belongs_to :skilled, :polymorphic => true
    belongs_to :module, class_name: "SystemModule"
    belongs_to :ability, class_name: "SystemAbility"
  
    validates :module, presence: true
    validates :ability, presence: true
  
    validates_uniqueness_of :ability_id, :scope => [:skilled_id, :module_id]
    validates_associated :skilled, :module, :ability
  
    #<=========================================================
  
    def self.for(skilled, system_module)
      find_all_by_skilled_id_and_module_id(skilled, system_module).collect { |ua| ua.ability }
    end
  
    def garant(skilled, system_module, ability)
      create!(:skilled => skilled, :module => system_module, :ability => ability)
    end
  end
end