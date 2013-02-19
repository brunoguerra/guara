require 'spec_helper'

module Guara
  describe ProfessionalController do
  
    describe "GET 'index'" do
      it "returns http success" do
        get 'index'
        response.should be_success
      end
    end
  
    describe "GET 'show'" do
      it "returns http success" do
        get 'show'
        response.should be_success
      end
    end
  
  end
end
