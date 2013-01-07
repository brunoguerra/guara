# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :customer_pj_has_customers_pj, :class => Guara::CustomerPjHasCustomersPj do
    from 1
    to 1
  end
end
