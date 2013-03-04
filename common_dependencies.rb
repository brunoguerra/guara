# By placing all of Spree's shared dependencies in this file and then loading
# it for each component's Gemfile, we can be sure that we're only testing just
# the one component of Spree.
source 'http://rubygems.org'

gem 'json'
gem 'sqlite3'
gem 'pg'
gem 'multi_json', "1.2.0"
gem 'activeadmin'
# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "~> 3.2"
  gem 'coffee-rails', "~> 3.2"
end

group :development, :test do
  gem 'guard'
  gem 'guard-rspec', '~> 0.5.5'
  gem 'spork', '0.9.0'
  gem 'guard-spork', '0.3.2'
  gem 'rspec-rails', '~> 2.11.0'
  gem 'email_spec', '~> 1.2.1'
  gem 'factory_girl_rails', '1.7.0'
end

group :test do
  gem 'ffaker'
  gem 'shoulda-matchers', '~> 1.0.0'
  #gem 'capybara', '1.1.3'
  #gem 'selenium-webdriver', '2.27.1'
  gem "capybara", "~> 2.0.2"
  gem "capybara-webkit", "~> 0.14.1"  
  gem 'database_cleaner', '0.7.1'
  gem 'launchy'
  # gem 'debugger'
end

gem 'active_extend', :path => "../../active_extend/"

gemspec