puts "loading guara/factories..."

#core factories
load Rails.root.join('../../../crm/spec/factories.rb')
Dir[File.expand_path("../../../crm/spec/factories/*.rb", __FILE__)].each {|f| load f}

FactoryGirl.define do
  factory :scheduled, :class => Guara::ActiveCrm::Scheduled do
    sequence(:subject) { |n|   "#{Faker::Name.name} -1- #{n}" }
    date_start 1.years.ago
    date_finish { Date.today + 1.day }
    user
  end

  factory :scheduled_group, :class => Guara::ActiveCrm::Scheduled::Group do
    scheduled
    employes_min 10
  end

  factory :scheduled_deals, :class => Guara::ActiveCrm::Scheduled::Deal do
    group factory: :scheduled_group
    scheduled { group.scheduled }
    customer { Factory(:customer_pj).customer }
    date_start { group.scheduled.date_start + 2.days }
    date_finish { date_start + 1.day }
    closed false
  end


  factory :scheduled_contact, :class => Guara::ActiveCrm::Scheduled::Contact do
    deal factory: :scheduled_deals
    user
    result Guara::ActiveCrm::Scheduled::Contact::ACCEPTED
    activity { Faker::Lorem.paragraphs(3).join('\n') }
    contact { deal.customer.contacts.first || FactoryGirl.create(:contact) }
  end

  factory :scheduled_ignored, :class => Guara::ActiveCrm::Scheduled::Ignored do
    customer
    group factory: :scheduled_group
  end
  
end