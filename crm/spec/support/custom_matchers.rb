require 'rspec/expectations'

#navigation

RSpec::Matchers.define :on_path do |expected|
  match do |page|
    page.current_path == expected
  end
end