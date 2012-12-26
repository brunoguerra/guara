
class Tests::LabAjaxController < BaseController
   
  def multiselection
    @customer = Customer.new
    @person = CustomerPj.new
    @customer.person = @person
    @person.segments.build
    
    render 'multiselection'
  end
  
  def data
    render 'public/data.txt'
  end
  
  def json_multi_business_segments
    res = []
    BusinessSegment.all.each {|b| res << {:key => b.id.to_s, :value => b.name} }
    render :json => res
  end
  
  def show
    self.send params[:id]
  end
  
end