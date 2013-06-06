require "spec_helper"

module Guara
  describe PlanContactsController do
    describe "routing" do
  
      it "routes to #index" do
        get("/plan_contacts").should route_to("plan_contacts#index")
      end
  
      it "routes to #new" do
        get("/plan_contacts/new").should route_to("plan_contacts#new")
      end
  
      it "routes to #show" do
        get("/plan_contacts/1").should route_to("plan_contacts#show", :id => "1")
      end
  
      it "routes to #edit" do
        get("/plan_contacts/1/edit").should route_to("plan_contacts#edit", :id => "1")
      end
  
      it "routes to #create" do
        post("/plan_contacts").should route_to("plan_contacts#create")
      end
  
      it "routes to #update" do
        put("/plan_contacts/1").should route_to("plan_contacts#update", :id => "1")
      end
  
      it "routes to #destroy" do
        delete("/plan_contacts/1").should route_to("plan_contacts#destroy", :id => "1")
      end
  
    end
  end
end
