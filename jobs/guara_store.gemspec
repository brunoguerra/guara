$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "guara/jobs/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "guara_jobs"
  s.version     = Guara::Jobs::VERSION
  s.authors     = ["Bruno Guerra"]
  s.email       = ["bruno@woese.com"]
  s.homepage    = "guara.woese.com"
  s.summary     = ""
  s.description = " "

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "guara_core"
  s.add_dependency "guara_crm"
  
  s.add_development_dependency 'pg', '~> 0.12.2'
  s.add_development_dependency 'rspec'
  
end
