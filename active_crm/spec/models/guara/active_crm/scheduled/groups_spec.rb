require 'spec_helper'

module Guara
  module ActiveCrm
    describe Scheduled::Group do

      let(:scheduled) { Factory(:scheduled) }
      let(:customer_pj) { Factory(:customer_pj) }
      let(:list_customer_pjs) { Factory(:customer_pj) }

      subject(:group) { Scheduled::Group.new(scheduled: scheduled, employes_min: 10) } 

      it { should respond_to(:to_contact) }
      it { should respond_to(:scheduleds) }
      it { should respond_to(:deals) }

      its(:to_contact) { should have(list_customer_pjs.size).items }

      let (:contacted_customer) { factory(:scheduled_contact, customer: list_customer_pjs.first}

    end
  end
end
