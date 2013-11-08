module Guara
  class Place < ActiveRecord::Base
    attr_accessible :enabled, :name

    has_one :geo, :as => :thing

  end
end
