module Guara
  module AbilityHelper
  
    class UserCantReceiveAbilityError < StandardError
    end
  
    def able(user, ability_str, module_str)
      ability_model = SystemAbility.find_by_name(ability_str.to_s.upcase)
      module_model = SystemModule.find_by_name(module_str.to_s.camelize)
      raise UserCantReceiveAbilityError.new "system ability dont exists %s." % ability_str if (ability_model==nil)
      raise UserCantReceiveAbilityError.new "system module dont exists. %s" % module_str if (module_model==nil)
      user.abilities.build(:module => module_model, :ability => ability_model).save
    end
  
  end
end