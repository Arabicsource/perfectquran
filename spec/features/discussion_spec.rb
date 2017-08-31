require 'rails_helper'
include Warden::Test::Helpers

feature "Discussion" do

  let(:topic_attribtes) { FactoryGirl.attributes_for(:topic) }

  before do
    # Given we have a user
    @user = FactoryGirl.create(:user)
    @user.confirm

    # And there is an ayah
    @ayah = FactoryGirl.create(:ayah)

    # And the user is logged in
    login_as @user
    
    # And the user is on a new topic page
    visit new_ayah_topic_path(@ayah)
    expect(current_url).to match "/ayahs/#{@ayah.id}/topics/new"
  end

  scenario "successful topic submission" do
    # When the user completes the form
    fill_in 'Subject', with: topic_attribtes[:subject]
    fill_in 'Content', with: topic_attribtes[:content]
    
    # And submits the form
    click_on 'Add Topic'

    # Then expect to be on the ayah page
    expect(current_url).to match "/#{@ayah.surah.id}/#{@ayah.number}"

    # And expect to have a success message
    expect(page).to have_css '.alert-success', text: I18n.t('topic.created')

    # And expect to have the topic subject included in the page
    expect(page).to have_text topic_attribtes[:subject]
  end
end