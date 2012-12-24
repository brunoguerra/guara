$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "guara_store/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "guara_store"
  s.version     = GuaraStore::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of GuaraStore."
  s.description = "TODO: Description of GuaraStore."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.5"
  s.add_dependency "jquery-rails"

  s.add_development_dependency 'pg', '~> 0.12.2'
end
