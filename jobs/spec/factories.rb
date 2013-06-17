puts "loading jobs/factories..."

#core factories
load Rails.root.join('../../../crm/spec/factories.rb') if ENV['factories_dependencies']!='false'

FactoryGirl.define do

  factory :custom_process, :class => Guara::Jobs::CustomProcess do
    sequence(:name) { |n| "#{Faker::Name.name}#{n}" }
  end

  factory :simple_customer, :class => Guara::Person do
  	name { Faker::Name.name }
  	doc { '' }
  end

  factory :professional, :class => Guara::Jobs::Professional do
	association :person, factory: :simple_customer
  end
  
end