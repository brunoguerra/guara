
module Guara
  module Skilled
    
    def able?(module_, ability)
      self.abilities.where(module_id: module_.id, ability_id: ability.id).count > 0 
    end
    
    def define_abilities(modules_and_abilities)
      labilities = []
    
      modules_and_abilities.each do |module_and_ability|
        labilities << abilities.build(module_and_ability)
      end
    
      self.abilities = labilities
    
    end
    
  end
end