$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "guara/core/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "guara_core"
  s.version     = GuaraCore::VERSION
  s.authors     = ["Bruno Guerra"]
  s.email       = ["bruno@woese.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of GuaraCore."
  s.description = "TODO: Description of GuaraCore."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  #s.test_files = Dir["spec/**/*"]

  s.require_path = 'lib'
  s.requirements << 'none'
    
  s.add_dependency "rails", "~> 3.2.9"
  
  s.add_dependency 'jquery-rails', '~> 2.0'
  s.add_dependency 'select2-rails', '~> 3.2'

  s.add_development_dependency "pg"
  s.add_dependency 'cancan', '1.6.8'
  s.add_dependency "active_extend"

end
