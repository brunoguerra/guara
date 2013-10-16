module Guara
  class User::Favorite < ActiveRecord::Base
    belongs_to :user
    belongs_to :thing
    # attr_accessible :title, :body
  end
end
