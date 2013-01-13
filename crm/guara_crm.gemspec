$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "guara/crm/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "guara_crm"
  s.version     = Guara::Crm::VERSION.dup
  s.authors     = ["Bruno Guerra"]
  s.email       = ["bruno@woese.com"]
  s.homepage    = "guara.woese.com"
  s.summary     = "CRM Module for Guara"
  s.description = "Customers, tasks and specific domains for provide good service"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "guara_core"
  s.add_dependency 'rails3-jquery-autocomplete'
  
  s.add_dependency 'brazilian-rails'
  
  s.add_development_dependency 'ffaker', '> 1.1'
  
end
