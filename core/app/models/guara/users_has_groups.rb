module Guara

  class UsersHasGroups < ActiveRecord::Base
    attr_accessible :user_id, :user_group_id
  
    belongs_to :user
    belongs_to :user_group
  
    validates :user_id, presence: true
    validates :user_group_id, presence: true
  end

end