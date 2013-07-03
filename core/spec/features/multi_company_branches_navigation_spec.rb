require 'spec_helper'

feature "Multi Company Branches Navigation" do
	
	let(:user) { Factory(:user) }

	before do
		user.company_branches = Array.new(2) { Factory(:company_branch) }
		user.save!

		sign_in user
	end

	scenario "change actual branch" do
			visit root_path()

			within('.company_branches') do
				select(user.company_branches.first, I18n.t('company_branches.title'))
			end

			except(current_company_branch).to be(user.company_branches.first)

	end

end