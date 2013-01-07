# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :customer_has_customers, :class => Guara::CustomerHasCustomers do
    from 1
    to 1
  end
end
