

def test_customer(name, doc)
  
  c = Guara::Customer.new
  c.name = name || ('A'..'Z').to_a.sample*12 + " " + ('A'..'Z').to_a.sample*8
  c.doc = doc || "0"*14
  c.customer = Guara::CustomerPj.new
  
  c.customer.segments << Guara::BusinessSegment.first
  c.customer.activities << Guara::BusinessActivity.first
  
  c.customer.save
  c.save
  
  c
end