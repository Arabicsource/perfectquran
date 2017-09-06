require 'rails_helper'
include Warden::Test::Helpers

feature "User Management" do
  let(:admin) { FactoryGirl.create(:user, :confirmed, :admin) }
  before { login_as admin }
  
  describe 'listing' do
    scenario "successfully" do
      users = FactoryGirl.create_list(:user, 5)
      visit manage_users_path
      expect(current_url).to match '/manage/users'
      users.each do |user|
        expect(page).to have_text user.username
      end
    end
  end
end