#encoding: utf-8
module Guara
  class Professional < Guara::Person
    attr_accessible :function_id, :formation 

    belongs_to :function_id

    has_many :formations
    has_many :formations, through: :professional_formations
    
  end
end