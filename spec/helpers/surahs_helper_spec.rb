require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the SurahsHelper. For example:
#
# describe SurahsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe SurahsHelper, type: :helper do

	describe "#breadcrumb" do

		specify do
			surah = FactoryGirl.create(:surah)
			breadcrumb = helper.breadcrumb(surah)
			expect(breadcrumb).to have_css "div.breadcrumb"
			expect(breadcrumb).to have_link "Home"
			expect(breadcrumb).to have_text surah.transliterated_name
		end
	end
end
