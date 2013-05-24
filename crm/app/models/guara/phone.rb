module Guara
  class Phone < ActiveRecord::Base
    belongs_to :callable
    attr_accessible :phone
  end
end
