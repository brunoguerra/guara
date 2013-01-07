# encoding: utf-8

require 'spec_helper'

module Guara
  describe CompanyBusiness do
  
    before do
      @business = CompanyBusiness.new(name: "Educacação Continuada", enabled: true)
    end
  
    it { should respond_to(:name) }
    it { should respond_to(:enabled) }
  
    it { should respond_to(:disabled?) }
    it { should respond_to(:destroy_fully) }
  
    it { should be_valid }
  
  end
end