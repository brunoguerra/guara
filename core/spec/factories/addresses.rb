# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :address do
    country_id 1
    state_id 1
    city_id 1
    district_id 1
    address "MyString"
    complement "MyString"
    postal_code "MyString"
  end
end
