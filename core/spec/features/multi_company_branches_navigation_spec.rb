require 'spec_helper'

feature "Multi Company Branches Navigation" do
	
	include Guara::SessionsHelper

	let(:user) { Factory(:user) }
	let(:admin) { Factory(:admin) }

	before do
		user.company_branches = Array.new(2) { Factory(:company_branch) }
		user.save

		able user, :read, 'CompanyBranch'

		sign_in user
	end

	scenario "change actual branch" do
			visit root_path()

			within('.company_branches') do
				click_on user.company_branches.first.name
			end

			expect(find('#current_branch')).to have_content(user.company_branches.first.name)
	end

end