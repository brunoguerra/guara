module Guara
  class Geo < ActiveRecord::Base
    attr_accessible :lat, :long
    belongs_to :thing, :polymorphic => true
  end
end
