module Guara
  class Settings < ActiveRecord::Base
    attr_accessible :key, :value

    def self.value(key)
      record = where(key: key).first
      record ? record.value : nil
    end
  end
end
