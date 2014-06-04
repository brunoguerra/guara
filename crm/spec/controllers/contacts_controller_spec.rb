require 'spec_helper'

describe Guara::ContactsController do

  def skip_routing
    method = ActionDispatch::Assertions::RoutingAssertions.instance_method(:with_routing).bind(self)
    method.call do |map|
      map.draw do
        # I've tried both of these versions:
        match ':controller/:action'
        #get 'subclass/:action' => 'subclass'
      end
      yield
    end
  end

  describe "GET /exporter/contacts" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      skip_routing do
        get :exporter
        response.status.should be(302)
      end
    end
  end
end
