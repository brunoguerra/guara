puts "loading core/factories..."

Dir[File.expand_path("../factories/*.rb", __FILE__)].each {|f| require f}

FactoryGirl.define do

  factory :user, :class => Guara::User do
    sequence(:name)  { Faker::Name.name }
    sequence(:email) { |n| "person_#{n}@example.com"}   
    password "foobar"
    password_confirmation "foobar"
    enabled true
    
    factory :admin do
      admin true
    end
  end

  factory :micropost, :class => Guara::Micropost do
    content "Lorem ipsum"
    user
  end
  
  factory :email, :class => Guara::Email do
    email Faker::Internet.email
  end
  
  factory :system_ability, :class => Guara::SystemAbility do
    factory :read do
      name "READ"
    end
  end
  
  factory :system_module, :class => Guara::SystemModule do
    factory :module_user do
      name "User"
    end
  end
  
  factory :state, :class => Guara::State do
    name { Faker::Name.name }
    acronym { ['CE', 'SP', 'AC', 'RO', 'RJ'].sample }
  end
    
  factory :city, :class => Guara::City do
    name { Faker::Name.name }
  end
  
  factory :district, :class => Guara::District do
    name { Faker::Name.name }
  end
  
  factory :user_ability, :class => Guara::UserAbility do
    skilled_id
    skilled_type "User"
    ability_id
    module_id
  end
  
  factory :user_group, :class => Guara::UserGroup do
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

puts "core/factories loaded!"