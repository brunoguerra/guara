$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "guara/store/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "guara_store"
  s.version     = Guara::Store::VERSION
  s.authors     = ["Bruno Guerra"]
  s.email       = ["bruno@woese.com"]
  s.homepage    = "guara.woese.com"
  s.summary     = ""
  s.description = " "

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "guara_core"
  s.add_dependency "guara_crm"
  s.add_dependency "spree_core"
  s.add_dependency "spree_api"
  s.add_dependency "spree_promo"
  s.add_dependency "spree_dash"
  
  s.add_development_dependency 'pg', '~> 0.12.2'
  s.add_development_dependency 'rspec'
  
end
