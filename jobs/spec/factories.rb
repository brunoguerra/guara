puts "loading jobs/factories..."

#core factories
load Rails.root.join('../../../crm/spec/factories.rb')

FactoryGirl.define do

  factory :custom_process, :class => Guara::Jobs::CustomProcess do
    sequence(:name) { |n| "#{Faker::Name.name}#{n}" }
  end
  
end