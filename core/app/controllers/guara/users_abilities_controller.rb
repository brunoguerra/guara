module Guara
  class UsersAbilitiesController < BaseController
    load_and_authorize_resource :user, class: Guara::User
    load_and_authorize_resource :abilities, through: :user, class: Guara::Ability
  
    def index
      @modules = SystemModule.all
      @abilities = SystemAbility.all
    end
  
    def create    
      abilities = []
    
      (params[:module] || []).each do |mdl_id, abilities_arr|
        mdl = SystemModule.find(mdl_id)
        abilities_arr.each do |ab_id,ab_id2|
          ab = SystemAbility.find(ab_id)
          abilities << { :module => mdl, :ability => ab }
        end
      end
    
      @user.define_abilities abilities
      @user.save
      
      @modules = SystemModule.all
      @abilities = SystemAbility.all
    
      authorize! :create, @abilities
      render "index"
    end
  
  end
end