
require 'spec_helper'
# tentativa require File.expand_path('../../../spec_helper', __FILE__)

#todo improve this requires
require File.expand_path('../../../../app/models/guara_store/product', __FILE__)

class GuaraStore::Product
  self.table_name "guara_store_products"  
end

describe GuaraStore::Product do
  
  before do
     @product = GuaraStore::Product.new
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