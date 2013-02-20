$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "guara/core/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "guara_core"
  s.version     = GuaraCore::VERSION
  s.authors     = ["Bruno Guerra"]
  s.email       = ["bruno@woese.com"]
  s.homepage    = "https://github.com/woese/guara/core/"
  s.summary     = "Guara Core."
  s.description = "Main features of Guara Application"
  
  s.files = Dir["{app,config,db,lib,vendor}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  #s.test_files = Dir["spec/**/*"]
  
  s.require_path = 'lib'
    
  s.add_dependency "rails", "~> 3.2.9"
  
  s.add_dependency 'jquery-rails', '2.2'
  s.add_dependency 'select2-rails', '~> 3.2'
  
  s.add_dependency 'bootstrap-sass', '~> 2.3.0.0'
  s.add_dependency 'formtastic', '2.2.1'
  s.add_dependency 'formtastic-bootstrap', '2.0.0'
  
  s.add_dependency "pg"
  s.add_dependency 'active_extend'
  s.add_dependency 'activeadmin', '0.5.0'
  s.add_dependency 'inherited_resources', '1.3.1'
  
  s.add_dependency  'bootstrap-will_paginate', '0.0.6'
  
  # Forms
  s.add_dependency  'will_paginate', '3.0.3'
  s.add_dependency  'rails3-jquery-autocomplete'

  #test support
  s.add_development_dependency  'faker', '1.0.1'

  #login rules
  s.add_dependency  'devise'
  s.add_dependency  'cancan', '~> 1.6.8'

  #model
  s.add_dependency  "meta_search", "1.1.3"
  #s.add_dependency "ransack", '~> 0.7.2'
  s.add_dependency  'activeadmin', '0.5.0'

  #criptar
  s.add_dependency  'bcrypt-ruby', '3.0.1'

  #internationalization and locales
  s.add_dependency  'rails-i18n'
  s.add_dependency  'brazilian-rails'
  
  #
  s.add_development_dependency 'annotate', '~> 2.4.1.beta'  
end
