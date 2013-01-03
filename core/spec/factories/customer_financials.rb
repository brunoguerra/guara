# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :customer_financial do
    billing_address_different "MyString"
    billing_address_id "MyString"
    contact_leader_id "MyString"
    payment_pending "MyString"
    payment_pending_message "MyString"
  end
end
