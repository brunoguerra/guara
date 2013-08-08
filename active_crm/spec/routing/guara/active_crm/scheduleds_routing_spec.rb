require "spec_helper"

module Guara
  describe ActiveCrm::ScheduledsController do
    describe "routing" do
  
      it "routes to #index" do
        get("/active_crm/Scheduleds").should route_to("active_crm/Scheduleds#index")
      end
  
      it "routes to #new" do
        get("/active_crm/Scheduleds/new").should route_to("active_crm/Scheduleds#new")
      end
  
      it "routes to #show" do
        get("/active_crm/Scheduleds/1").should route_to("active_crm/Scheduleds#show", :id => "1")
      end
  
      it "routes to #edit" do
        get("/active_crm/Scheduleds/1/edit").should route_to("active_crm/Scheduleds#edit", :id => "1")
      end
  
      it "routes to #create" do
        post("/active_crm/Scheduleds").should route_to("active_crm/Scheduleds#create")
      end
  
      it "routes to #update" do
        put("/active_crm/Scheduleds/1").should route_to("active_crm/Scheduleds#update", :id => "1")
      end
  
      it "routes to #destroy" do
        delete("/active_crm/Scheduleds/1").should route_to("active_crm/Scheduleds#destroy", :id => "1")
      end
  
    end
  end
end
