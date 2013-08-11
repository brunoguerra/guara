require 'spec_helper'

module Guara::ActiveCrm
  describe Scheduled do
    before do
      @scheduled = Scheduled.new(
                    :subject => "Test", 
                    :date_start => Date.today,
                    :date_finish => Date.today + 5.days,
                    :task_type => Factory(:task_type),
                  )
    end

    it { should respond_to(:subject) }
    it { should respond_to(:user_id) }
    it { should respond_to(:deals) }


    context "with groups" do
      let(:group) { Factory(:scheduled_customer_group, scheduled: @scheduled) }

      it { group.scheduled.should be @scheduled }

      context "with deals" do
        let(:customer_pj) { Factory(:customer_pj) }
        let(:deals) { Array.new(2) { Factory(:scheduled_customer_group_deals, customer: customer_pj.person, group: group) } }

        it "has deals" do
          @scheduled.deals.should have(deals.size).items
        end
      end

    end
  end
end
