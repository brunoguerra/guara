
module Attributable
  def attributes=(attrs)
    attrs.each do |attr, value|
      self.send((attr.to_s+'=').to_sym, value)
    end
  end

  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def bulk_build(records = [])
      records = yield block_given?
      result = []
      records.each do |c|
        result << self.new(c)
      end
      result
    end
  end

  

end