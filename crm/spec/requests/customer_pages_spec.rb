
include LocaleHelper

describe "Customer Pages" do
  
  let(:admin) { Factory :admin }
  
  before do
    sign_in admin
  end
  
  subject { page }
  
  describe "customer pj" do
    
    let(:customer) { Factory(:customer_pj).customer }  
    let(:customers) { Array.new(5) { Factory(:customer_pj).customer } }
    
    before { visit customer }
    
    describe "show customer" do
      
      describe "field associateds" do
        before { customer.person.associate_to(Factory(:customer_pj).person) }
        
        it { should have_content(customer.person.associateds[0].name) }
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