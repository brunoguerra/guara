module Guara

  class Micropost < ActiveRecord::Base
    belongs_to :user
  
    attr_accessible :content

    validates :content, presence: true, length: { maximum: 140 }
    validates :user_id, presence: true

    default_scope order: 'guara_microposts.created_at DESC'
  end
end