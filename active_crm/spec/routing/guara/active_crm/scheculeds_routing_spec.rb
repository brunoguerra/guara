require "spec_helper"

module Guara
  describe ActiveCrm::ScheculedsController do
    describe "routing" do
  
      it "routes to #index" do
        get("/active_crm/scheculeds").should route_to("active_crm/scheculeds#index")
      end
  
      it "routes to #new" do
        get("/active_crm/scheculeds/new").should route_to("active_crm/scheculeds#new")
      end
  
      it "routes to #show" do
        get("/active_crm/scheculeds/1").should route_to("active_crm/scheculeds#show", :id => "1")
      end
  
      it "routes to #edit" do
        get("/active_crm/scheculeds/1/edit").should route_to("active_crm/scheculeds#edit", :id => "1")
      end
  
      it "routes to #create" do
        post("/active_crm/scheculeds").should route_to("active_crm/scheculeds#create")
      end
  
      it "routes to #update" do
        put("/active_crm/scheculeds/1").should route_to("active_crm/scheculeds#update", :id => "1")
      end
  
      it "routes to #destroy" do
        delete("/active_crm/scheculeds/1").should route_to("active_crm/scheculeds#destroy", :id => "1")
      end
  
    end
  end
end
