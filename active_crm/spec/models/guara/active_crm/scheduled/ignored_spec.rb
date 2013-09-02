require 'spec_helper'

module Guara
  module ActiveCrm
    describe Scheduled::Ignored do
      
      let(:customer) { Factory(:customer) }
      let(:group) { Factory(:scheduled_group)}

      subject(:ignored) do
        Scheduled::Ignored.new(customer: customer, group: group)
      end

      it { should respond_to(:customer) }
      it { should respond_to(:group) }
    end
  end
end
