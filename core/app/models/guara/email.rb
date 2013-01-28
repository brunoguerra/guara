module Guara
  class Email < ActiveRecord::Base
    attr_accessible :customer_id, :email, :infos, :private, :emailable
  
    belongs_to :emailable, :polymorphic => true
  
    #validates :emailable, presence: true
  end
end
