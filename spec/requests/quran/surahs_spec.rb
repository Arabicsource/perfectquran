# frozen_string_literal: true

require 'rails_helper'

describe 'Surahs', type: :request do
  context 'GET root' do
    before(:each) { get root_path }

    it 'responds succeessfully' do
      expect(response).to be_successful
    end

    it 'renders quran/surahs#index' do
      expect(response).to render_template 'quran/surahs/index'
    end
  end

  context 'GET quran_root as admin' do
    it 'responds successfully' do
      login_as FactoryBot.create(:admin)
      get quran_root_path

      expect(response).to be_successful
    end
  end

  context 'GET quran_root' do
    before(:each) { get quran_root_path }

    it 'responds succeessfully' do
      expect(response).to be_successful
    end

    it 'renders quran/surahs#index' do
      expect(response).to render_template 'quran/surahs/index'
    end
  end

  context 'GET index' do
    before(:each) { get quran_surahs_path }

    it 'responds successfully' do
      expect(response).to be_successful
    end
  end

  context 'GET show' do
    it 'responds successfully' do
      surah = create :surah

      get quran_surah_path(surah)

      expect(response).to be_successful
    end
  end

  context 'GET permalink' do
    it 'responds successfully' do
      surah = create :surah

      get "/#{surah.permalink}"

      expect(response).to be_successful
    end

    it 'renders quran/surahs/show' do
      surah = create :surah

      get "/#{surah.permalink}"

      expect(response).to render_template 'quran/surahs/show'
    end
  end
end
