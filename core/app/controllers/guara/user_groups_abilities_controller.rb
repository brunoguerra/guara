module Guara
  class UserGroupsAbilitiesController < BaseController
    load_and_authorize_resource :user_group, class: Guara::UserGroup
    load_and_authorize_resource :abilities, through: :user_group, class: Guara::UserAbility
  
    def create
      abilities = get_grid_editable_abilities(param)
    
      @user_group.define_abilities abilities
      @user_group.save
    end
  
  end
end