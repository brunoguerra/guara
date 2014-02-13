
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
          if (ab.module.name.downcase == "all")
            resource = :all
          else
            begin
              #Rails.logger.debug "Trying %s"% [ab.module.name]
              resource = module_by_name(ab.module.name)
            rescue
              Rails.logger.debug "FALHA EM: %s:%d %s"% [__FILE__,__LINE__, ab.module.name]
            end
          end
      
          t_ability = ab.ability.name.downcase.to_sym
          can t_ability, resource
          #Rails.logger.debug ("ability: :%s, resource: %s" % [ab.ability.name.downcase.to_sym.to_s, resource.to_s])
        
          if (t_ability.to_sym == :read)
            can [:index, :show], resource
          elsif (t_ability.to_sym == :create)
            can [:new], resource
          elsif (t_ability.to_sym == :delete)
            can [:destroy], resource
          end
        end 
      end
    end
    
    def module_by_name(name)
      eval name
    end
    
    def can?(action, subject, *extra_args)
        ret = super
        Rails.logger.debug ("***-CAN'T action: :%s, subject: %s" % [action.to_s, subject.to_s]) if !ret
        ret
    end
  end
end
