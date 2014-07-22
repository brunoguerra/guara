module Guara
  class Currency < ActiveRecord::Base
    attr_accessible :code, :description, :symbol
  end
end
