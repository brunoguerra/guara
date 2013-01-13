puts "loading crm/factories..."

#core factories
load Rails.root.join('../../../core/spec/factories.rb')

FactoryGirl.define do

  factory :customer, :class => Guara::Customer do
    sequence(:name) { |n|   "#{Faker::Name.name}#{n}" }
    birthday 100.years.ago
    doc '0'*14
    complete false
    
    factory :interested do
      #specialized
    end
  end
  
  
  factory :customer_pj, :class => Guara::CustomerPj do
    fax 9999
    after_build do |pj|
      FactoryGirl.create(:customer, :person => pj)
    end
  end

  factory :contact, :class => Guara::Contact do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:birthday) { |n| (n+15).years.ago }
    customer
  end
  
  factory :business_segment, :class => Guara::BusinessSegment do
    name { Faker::Name.name }
  end
  
  factory :business_activity, :class => Guara::BusinessActivity do
    name { Faker::Name.name }
  end
  
end
puts "crm/factories loaded!"