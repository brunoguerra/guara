# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :task_feedback, :class => Guara::TaskFeedback do
    
    task
    user
    
    date "2012-09-11 04:08:36"
    notes { Faker::Lorem.sentence(2) }
    status_id Guara::SystemTaskStatus.OPENED
    resolution_id Guara::SystemTaskResolution.BLOCKED
    
    factory :business_done do
      resolution Guara::SystemTaskResolution.RESOLVED_WITH_BUSINESS
    end
    
  end
end
