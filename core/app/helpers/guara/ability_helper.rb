module Guara
  module AbilityHelper
  
    class UserCantReceiveAbilityError < StandardError
    end
  
    def able(skilled, abilities, module_str)

      module_model = AbilityHelper.module_by_name(module_str)

      unless abilities.is_a? Array
        abilities = [abilities]
      end

      abilities.each do |ability|
        ability_model = AbilityHelper.ability_by_name(ability)
        skilled.abilities.create(:module => module_model, :ability => ability_model)
      end
    end
    
    def self.ability_by_name(ability_str)
      ability_model = SystemAbility.find_by_name(ability_str.to_s.upcase)
      raise UserCantReceiveAbilityError.new "system ability dont exists %s." % ability_str if (ability_model==nil)
      ability_model
    end

    def self.module_by_name(module_str)
      module_model = SystemModule.find_by_name(module_str.to_s.camelize)
      raise UserCantReceiveAbilityError.new "system module dont exists. %s" % module_str if (module_model==nil)
      module_model
    end

    
    def get_grid_editable_abilities(module_params)
      
      abilities = []
      
      (module_params[:module] || []).each do |mdl_id, abilities_arr|
        mdl = SystemModule.find(mdl_id)
        abilities_arr.each do |ab_id,ab_id2|
          ab = SystemAbility.find(ab_id)
          abilities << { :module => mdl, :ability => ab }
        end
      end
      
      return abilities
    end
  
  end
end