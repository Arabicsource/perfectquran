# frozen_string_literal: true

require 'rails_helper'

describe 'Quran::SurahsController', type: :request do
  let(:account) { create :account }

  describe 'GET quran_root_path' do
    before { get quran_root_path }

    specify { expect(response).to be_successful }
    specify { expect(response).to have_title 'Surahs' }
  end

  describe 'GET quran_surahs_path' do
    before { get quran_surahs_path }

    specify { expect(response).to be_successful }
    specify { expect(response).to have_title 'Surahs' }
  end

  describe 'GET quran_surah_path' do
    before { get quran_surah_path('al-fatihah') }

    specify { expect(response).to be_successful }
    specify { expect(response).to have_title 'Al-Fatihah' }
    specify { expect(response).to have_path '/quran/al-fatihah' }
  end
end
