require 'spec_helper'

describe Guara::Product do
  
  before do
     @product = Guara::Product.new
  end
  
  subject { @product }
  
  it { should respond_to(:name) }
  it { should respond_to(:prices) }
  it { should respond_to(:description) }
  it { should respond_to(:type) }
  it { should respond_to(:reference) }
  it { should respond_to(:enabled) }
  it { should respond_to(:in_stock?) }
  it { should respond_to(:current_stock) }
  it { should respond_to(:manufacturer) }
  
end