

module Guara
  describe Order do
    
    before do
       @order = Order.new(person: Factory(:customer),
                          type: OrderType.IN,
                          state: OrderState.BUDGET,
                          date_init: 2.days.ago,
                          )
    end
    
    subject { @order }
    
    it { should respond_to(:date_init) }
    it { should respond_to(:person) }
    it { should respond_to(:type) }
    it { should respond_to(:state) }
    it { should respond_to(:state_date) }
    it { should respond_to(:date_finish) }
    it { should respond_to(:payment_date) }
    it { should respond_to(:payment_state) }
    
    describe "changed state" do
      before { @order.state = OrderState.ORDERED }
      
      it { @order.state_date.strftime("%d/%m/%Y").should == Time.now.strftime("%d/%m/%Y") }
      it { @order.state.should == OrderState.ORDERED }
    end
    
  end
end