require 'spec_helper'

module Guara

  include LocaleHelper

  describe "Customer Pages" do
  
    let(:admin) { Factory :admin }
  
    before do
      I18n.reload!
      sign_in admin
    end
  
    subject { page }
  
    describe "customer pj" do
    
      let(:customer) { Factory(:customer_pj).person }  
      let(:customers) { Array.new(5) { Factory(:customer_pj).customer } }
      let(:state) { Factory(:state) }
      let(:city) { Factory(:city, state: state) }
      let(:district) { Factory(:district, city: city) }
      
      let(:segment) { Factory(:business_segment) }
      let(:activity) { Factory(:business_activity) }
    
      before { visit guara.customers_path(customer) }
      
      describe "new with full data", :js => true do
        before do
          #create dependencies
          district
          segment
          activity
          
          #access new page
          visit guara.new_customer_path
          
          fill_in I18n.t("customers.name"),       with: "TESTE CLIENTE"
          fill_in I18n.t("customer_pjs.doc"),        with: "02135533000106"
          #fill_in I18n.t("customer_pjs.doc_rg"),     with: "A123"
          fill_in I18n.t("customers.name_sec"),   with: "TESTE RAZAO"
          
          select district.city.state.acronym,     from: I18n.t("customers.state")
          select district.city.name,        from: I18n.t("customers.city")
          select district.name,    from: I18n.t("customers.district")
          
          fill_in I18n.t("customers.phone"),      with: "85 88891234"
          
          
          find("li#segments_select_annoninput input").set segment.name
          wait_for_response()
          wait_for_animations()
          find("ul#segments_select_feed li").click()
          
          find("li#activities_select_annoninput input:first-child").set activity.name
          wait_for_response()
          wait_for_animations()
          find("ul#activities_select_feed li").click()
          
        end
        
        it { expect { find(".btn-primary").click() }.to change(Customer, :count).by(1) }
        it "xyz" do
           
           expect { find(".btn-primary").click() }.to change(CustomerPj, :count).by(1)
        end
        it { expect { find(".btn-primary").click() }.to change(CustomerSegment, :count).by(1) }
        it { expect { find(".btn-primary").click() }.to change(CustomerActivity, :count).by(1) }
      end
      
      describe "show customer" do
      
        describe "field associateds" do
          before { customer.customer.associate_to(Factory(:customer_pj).customer) }
          it { should have_content(customer.customer.associateds[0].name) }
        end
      
    
        describe "bussiness of customer", :js => true do
          let!(:task_types) { Array.new(2) { Factory(:task_type, company_business: Factory(:company_business)) } }
          let!(:customer) { customer }
          before do
            @tasks = 2.times.map do |i|
              @task = Factory(:task, type: task_types[i-1], 
                                          status: SystemTaskStatus.CLOSED, 
                                          resolution: SystemTaskResolution.RESOLVED_WITH_BUSINESS, 
                                          interested: customer)
               Factory :business_done, task: @task
               @task
            end
        
            visit customer_path(customer)
            wait_for_animations
          end
      
          it { find("#businesses").should have_content task_types[0].company_business.name }
      
          it "should contains all businesses added" do
            customer.businesses.each do |b|
              find("#businesses").should have_content b.business.name
              find("#businesses").should have_content format_date(b.business_at)
            end
          end
      
        end
      end
    end
  
  end
end