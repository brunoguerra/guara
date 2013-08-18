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
      let(:group) { Factory(:scheduled_group, scheduled: @scheduled) }

      it { group.scheduled.should be @scheduled }

      context "with deals" do
        let(:customer_pj) { Factory(:customer_pj) }
        let(:deals) { Array.new(2) { Factory(:scheduled_deals, customer: customer_pj.person, group: group) } }

        it "has deals" do
          @scheduled.deals.should have(deals.size).items
        end
      end

      describe "#initialize_deal" do
        let(:customer) { Factory(:customer) }
        before { @deal = @scheduled.initialize_deal(customer) }

        it "initializes a real deal" do
          @deal.should be_true
        end

        it "initializes a valid deal" do
          @deal.should be_valid
        end
      end

    end
  end
end
