module Guara
  module AbilityHelper
  
    class UserCantReceiveAbilityError < StandardError
    end
  
    def able(skilled, ability_str, module_str)
      ability_model = SystemAbility.find_by_name(ability_str.to_s.upcase)
      module_model = SystemModule.find_by_name(module_str.to_s.camelize)
      raise UserCantReceiveAbilityError.new "system ability dont exists %s." % ability_str if (ability_model==nil)
      raise UserCantReceiveAbilityError.new "system module dont exists. %s" % module_str if (module_model==nil)
      skilled.abilities.build(:module => module_model, :ability => ability_model).save
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