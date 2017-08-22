require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do

	describe "#page_title" do

    it "returns `Perfect Quran` when called without arguments" do
      expect(helper.page_title).to eq "Perfect Quran"
    end

    it "returns `Title | Perfect Quran` when called with an argument" do
      expect(helper.page_title("Title")).to eq "Title | Perfect Quran"
    end
	end

end