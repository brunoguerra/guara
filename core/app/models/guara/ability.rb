
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
              resource = eval(ab.module.name)
            rescue
              Rails.logger.debug "FALHA EM: %s:%d"% [__FILE__,__LINE__]
            end
          end
      
          t_ability = ab.ability.name.downcase.to_sym
          can t_ability, resource
          Rails.logger.debug ("ability: :%s, resource: %s" % [ab.ability.name.downcase.to_sym.to_s, resource.to_s])
        
          if (t_ability.to_sym == :read)
            can [:index, :show], resource
          elsif (t_ability.to_sym == :create)
            can [:new], resource
          end
        end 
      end
    end
    
    def can?(action, subject, *extra_args)
        Rails.logger.debug ("cancan::Ability.can? action: :%s, subject: %s" % [action.to_s, subject.to_s])      
        ret = super 
        #if (!ret && !subject.nil?)
        #  old_subject = subject
        #  subject = subject.superclass
        #  ret = super
        #  subject = old_subject 
        #end
        Rails.logger.debug ("***-CAN'T action: :%s, subject: %s" % [action.to_s, subject.to_s]) if !ret
        ret
    end
  end
end
