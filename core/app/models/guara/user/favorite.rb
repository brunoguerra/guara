module Guara
  class User::Favorite < ActiveRecord::Base
    belongs_to :user
    belongs_to :thing, :polymorphic => true
    attr_accessible :user_id, :thing
  end
end
