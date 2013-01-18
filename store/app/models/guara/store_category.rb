module Guara
  class StoreCategory < ActiveRecord::Base
    attr_accessible :enabled, :name, :parent_id
  end
end
