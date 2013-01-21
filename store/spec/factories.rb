puts "loading store/factories..."

#core factories
load Rails.root.join('../../../crm/spec/factories.rb')

FactoryGirl.define do

  factory :category, :class => Guara::StoreCategory do
    sequence(:name) { |n|   "#{Faker::Name.name}#{n}" }
  end
  
end