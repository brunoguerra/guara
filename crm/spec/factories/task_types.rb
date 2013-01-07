# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :task_type, :class => Guara::TaskType do
    name { Faker::Name.first_name }
    enabled true
  end
end
