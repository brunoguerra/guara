module Guara
  class Scheduled::Contact < ActiveRecord::Base
    belongs_to :contact
    belongs_to :classified
    attr_accessible :activity, :result, :scheduled
  end
end
