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
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.9"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
end
