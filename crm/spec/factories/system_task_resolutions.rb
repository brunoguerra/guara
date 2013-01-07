# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :system_task_resolution, :class => Guara::SystemTaskResolution do
    name { Faker::Name.first_name }
  end
end
