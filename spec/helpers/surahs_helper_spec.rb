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

  describe "#previous_next_links" do

    specify do
      surah = FactoryGirl.create(:surah)
      previous_next_links = helper.previous_next_links(surah)
      expect(previous_next_links).to have_link "Previous"
      expect(previous_next_links).to have_link "Next"
    end
  end

  describe "#ayah_is_favorited?" do
    specify do
      favorite = FactoryGirl.create(:favorite)
      expect(helper.ayah_is_favorited?(favorite.user,  favorite.ayah)).to be_truthy
    end

    specify "when user is nil the result is falsey" do
      favorite = FactoryGirl.create(:favorite)
      expect(helper.ayah_is_favorited?(nil, favorite.ayah)).to be_falsey
    end
  end
end
