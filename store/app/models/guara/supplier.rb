module Guara
  class Supplier < ActiveRecord::Base
    attr_accessible :person, :person_id

    belongs_to :person
  end
end
