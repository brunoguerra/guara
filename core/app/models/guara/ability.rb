
require 'cancan'

module Guara

  class Ability
    include CanCan::Ability

    def initialize(user)
    
      user ||= User.new # guest user (not logged in)
      if user.admin?
        can :manage, :all
      else
      
        abilities = user.all_abilities
      
        abilities.each do |ab|
          if (ab.module=="all")
            resource = :all
          else
            resource = eval(ab.module.name)
          end
      
          t_ability = ab.ability.name.downcase.to_sym
          can t_ability, resource
          Rails.logger.debug ("ability: :%s, resource: %s" % [ab.ability.name.downcase.to_sym.to_s, resource.to_s])
        
          if (t_ability.to_sym == :read)
            can [:index, :show], resource
          end
        end 
      end
    
      def can?(action, subject, *extra_args)
          Rails.logger.debug ("cancan::Ability.can? action: :%s, subject: %s" % [action.to_s, subject.to_s])      
          ret = super 
          Rails.logger.debug ("***-CAN'T action: :%s, subject: %s" % [action.to_s, subject.to_s]) if !ret
          ret
      end
    end
  end
end

class ::Ability < Guara::Ability; end