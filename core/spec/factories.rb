FactoryGirl.define do

  factory :user do
    sequence(:name)  { Faker::Name.name }
    sequence(:email) { |n| "person_#{n}@example.com"}   
    password "foobar"
    password_confirmation "foobar"
    enabled true
    
    factory :admin do
      admin true
    end
  end
  
  factory :customer do
    sequence(:name) { |n|   "#{Faker::Name.name}#{n}" }
    birthday 100.years.ago
    doc '0'*14
    complete false
    
    factory :interested do
      #specialized
    end
  end
  
  
  factory :customer_pj do
    fax 9999
    after_build do |pj|
      FactoryGirl.create(:customer, :person => pj)
    end
  end

  factory :micropost do
    content "Lorem ipsum"
    user
  end
  
  factory :contact do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:birthday) { |n| (n+15).years.ago }
    customer
  end
  
  factory :email do
    email Faker::Internet.email
  end
  
  factory :system_ability do
    factory :read do
      name "READ"
    end
  end
  
  factory :system_module do
    factory :module_customer do
      name "Customer"
    end
  end
  
  factory :state do
    name { Faker::Name.name }
  end
    
  factory :city do
    name { Faker::Name.name }
  end
  
  factory :district do
    name { Faker::Name.name }
  end
  
  factory :business_segment do
    name { Faker::Name.name }
  end
  
  factory :business_activity do
    name { Faker::Name.name }
  end
  
  factory :user_ability do
    skilled_id
    skilled_type "User"
    ability_id
    module_id
  end
  
  factory :user_group do
    sequence(:name)  { |n| "Group #{n}" }
    factory :group_able_users do
      after_build do |g|
      
      end
    end
  end
  
  factory :status do
    name { Faker::Name.first }
  end

end