
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
    
      #
      # The first argument to `can` is the action you are giving the user permission to do.
      # If you pass :manage it will apply to every action. Other common actions here are
      # :read, :create, :update and :destroy.
      #
      # The second argument is the resource the user can perform the action on. If you pass
      # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
      #
      # The third argument is an optional hash of conditions to further filter the objects.
      # For example, here the user can only update published articles.
      #
      #   can :update, Article, :published => true
      #
      # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
    end
  end
end