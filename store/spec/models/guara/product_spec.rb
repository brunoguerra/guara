require 'spec_helper'

module Guara
  describe Product do
  
    before do
       @product = Guara::Product.new
    end
  
    subject { @product }
  
    it { should respond_to(:name) }
    it { should respond_to(:prices) }
    it { should respond_to(:description) }
    it { should respond_to(:categories) }
    it { should respond_to(:primary_category) }
    it { should respond_to(:sku) }
    it { should respond_to(:enabled) }
    it { should respond_to(:in_stock?) }
    it { should respond_to(:current_stock) }
    it { should respond_to(:stock=) }
    it { should respond_to(:manufacturer) }
    
    describe "in_stock? after changed stock value" do
      it "should be in stock after change stock to positive value" do
        @product.stock = 100
        should be_in_stock
      end
      
      it "stock should empty after change stock to zero or negative value" do
        @product.stock = 0
        should_not be_in_stock
        
        @product.stock = -1
        should_not be_in_stock
      end
    end
    
    describe "product categories" do
      before do
        @categories = Array.new(5) { Factory(:category) }
        @categories.each {|category|  @product.categories << category }
      end
        
      its(:categories) { @categories.each { |category| should include(category) } }
    end
    
  
  end
end