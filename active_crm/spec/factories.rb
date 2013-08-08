puts "loading guara/factories..."

#core factories
load Rails.root.join('../../../crm/spec/factories.rb')
Dir[File.expand_path("../../../crm/spec/factories/*.rb", __FILE__)].each {|f| load f}

FactoryGirl.define do
  factory :scheduled, :class => Guara::ActiveCrm::Scheduled::Scheduled do
    sequence(:subject) { |n|   "#{Faker::Name.name}#{n}" }
    date_start 1.years.ago
    date_finish { Date.now + 1.day }
  end

  factory :customer_group, :class => Guara::ActiveCrm::Scheduled::CustomerGroup do
    employes_min 10

  end

  factory :scheduled_contact, :class => Guara::ActiveCrm::Scheduled do
    sequence(:subject) { |n|   "#{Faker::Name.name}#{n}" }
    date_start 1.years.ago
    date_finish { Date.now + 1.day }
  end

  
end