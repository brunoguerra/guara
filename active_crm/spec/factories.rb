puts "loading guara/factories..."

#core factories
load Rails.root.join('../../../core/spec/factories.rb')
Dir[File.expand_path("../../../core/spec/factories/*.rb", __FILE__)].each {|f| load f}

FactoryGirl.define do
  
end