# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :business_department do
    name { Faker::Name.name[0..39] }
    enabled true
  end
end
