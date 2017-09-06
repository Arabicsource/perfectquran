require 'rails_helper'
include Warden::Test::Helpers

feature "Discussion" do

  let(:topic_attribtes) { FactoryGirl.attributes_for(:topic) }
  let(:user) { FactoryGirl.create(:user, :confirmed) }
  let(:ayah) { FactoryGirl.create(:ayah) }
  let(:topic) { FactoryGirl.create(:topic) }
  let(:comment_attributes) { FactoryGirl.attributes_for(:comment) }

  before { login_as user }

  describe 'creating a new topic' do
    scenario "successfully" do
      visit new_ayah_topic_path(ayah)
      expect(current_url).to match "/ayahs/#{ayah.id}/topics/new"
      
      fill_in 'Subject', with: topic_attribtes[:subject]
      fill_in 'Content', with: topic_attribtes[:content]
      click_on 'Add Topic'
  
      expect(current_url).to match "/#{ayah.surah.id}/#{ayah.number}"
      expect(page).to have_css '.alert-success', text: I18n.t('topic.created')
      expect(page).to have_text topic_attribtes[:subject]
    end
  end
  

  describe 'adding a comment to a topic' do
    scenario 'successfully' do
      visit topic_path(topic)
      expect(current_url).to match "/topics/#{topic.id}"

      fill_in 'Content', with: comment_attributes[:content]
      click_on 'Add Comment'

      expect(current_url).to match "/topics/#{topic.id}"
      expect(page).to have_css '.alert-success', text: I18n.t('comment.created')
      expect(page).to have_text comment_attributes[:content]
    end
  end
end