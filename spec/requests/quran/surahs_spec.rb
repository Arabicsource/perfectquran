# frozen_string_literal: true

require 'rails_helper'

describe 'Surahs', type: :request do

  context 'GET index' do
    before(:each) { get quran_surahs_path }

    it 'responds successfully' do
      expect(response).to be_successful
    end

    it 'uses fullpage layout' do
      expect(response).to render_template layout: 'fullpage'
    end
  end

  context 'GET show' do
    before do
      @surah = FactoryGirl.create(:surah)
    end
    
    it 'response successfully' do
      get quran_surah_path(@surah)

      expect(response).to be_successful
    end
  end
end
