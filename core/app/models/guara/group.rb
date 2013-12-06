module Guara
  class Group < ActiveRecord::Base
    belongs_to :parent
    belongs_to :module, :polymorphic => true
    attr_accessible :name, :sumary, :module
  end
end
