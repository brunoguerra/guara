module Guara
  class AbilitiesController < BaseController
  
  
    def index
      preload
      authorize! :index, @user_abilities
    end
  
    def create
      preload
    
      abilities = []
    
      params[:module].each do |mdl_id, abilities_arr|
        mdl = SystemModule.find(mdl_id)
        abilities_arr.each do |ab_id,ab_id2|
          ab = SystemAbility.find(ab_id)
          abilities << { :module => mdl, :ability => ab }
        end
      end
    
      @user.define_abilities abilities
      @user.save
    
      authorize! :create, @user_abilities
      render "index"
    end
  
    def preload
      @user = User.find params[:user_id]
      @user_abilities = @user.abilities
      @modules = SystemModule.all
      @abilities = SystemAbility.all
    end
  
  end
end