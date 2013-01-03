FactoryGirl.define do
  factory :task do
    after_build do |h|
      contact { FactoryGirl.create(:contact) }
      task_type_id { FactoryGirl.create(:task_type) }
    end
  
    interested
    user
  
    name { ("three"+Faker::Lorem.sentence(3))[0..59] }
    due_time 1.hour.ago
    notes { Faker::Lorem.paragraph(2)[0..139] }
    description { Faker::Lorem.paragraph(10) }
    status { SystemTaskStatus.OPENED }
  end
end