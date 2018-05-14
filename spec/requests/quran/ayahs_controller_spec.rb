# frozen_string_literal: true

require 'rails_helper'

describe 'Quran::AyahsController', type: :request do
  let(:account) { create :account }

  describe 'GET by reference' do
    before { get '/1/1' }

    specify { expect(response).to be_successful }
  end

  describe 'GET by reference with translation' do
    before { get '/1/1/1' }

    specify { expect(response).to be_successful }
  end

  describe 'GET quran_ayah_path' do
    context 'when not logged in' do
      before { get quran_ayah_path('al-fatihah', 1) }

      specify { expect(response).to be_successful }
    end

    context 'when not logged in on mobile' do
      before do
        mobile_browser
        get quran_ayah_path('al-fatihah', 1)
      end

      specify { expect(response).to be_successful }
    end

    context 'when logged in' do
      before do
        login_as account
        get quran_ayah_path('al-fatihah', 1)
      end

      specify { expect(response).to be_successful }
    end

    context 'when logged in on mobile' do
      before do
        login_as account
        mobile_browser
        get quran_ayah_path('al-fatihah', 1)
      end

      specify { expect(response).to be_successful }
    end
  end

  describe 'GET study/ayahs/:id' do
    before { get '/study/ayahs/1' }

    specify { expect(response).to redirect_to '/quran/al-fatihah/1' }
  end

  describe 'GET quran/:id/:number' do
    before { get '/quran/1/1' }

    specify { expect(response).to redirect_to '/quran/al-fatihah/1' }
  end
end
