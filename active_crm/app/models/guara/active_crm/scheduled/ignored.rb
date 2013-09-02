module Guara
    module ActiveCrm
    class Scheduled::Ignored < ActiveRecord::Base
      attr_accessible :customer_id, :group_id, :customer, :group

      belongs_to :group, class_name: "Scheduled::Group"
      belongs_to :customer
    end
  end
end