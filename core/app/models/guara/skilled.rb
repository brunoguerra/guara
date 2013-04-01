
module Guara
  module Skilled
    
    def able?(module_, ability)
      if self.respond_to?(:all_abilities)
        abilities = self.all_abilities.reject! { |a| !(a.module == module_ && a.ability == ability) }
        !abilities.nil? && abilities.size() > 0
      else
        self.abilities.where(module_id: module_.id, ability_id: ability.id).count > 0 
      end
    end
    
    def define_abilities(modules_and_abilities)
      self.abilities = []
      modules_and_abilities.each do |module_and_ability|
        self.abilities.build(module_and_ability)
      end
    end
    
  end
end