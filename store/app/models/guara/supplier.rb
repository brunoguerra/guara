module Guara
  class Supplier < ActiveRecord::Base
    attr_accessible :customer_pj_id

    belongs_to :customer_pj
  end
end
