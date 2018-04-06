# frozen_string_literal: true

require 'rails_helper'

describe 'Study::SurahsController', type: :request do
  let(:account) { create :account }

  describe 'GET root_path' do
    before { get root_path }

    specify { expect(response).to be_successful }
  end

  describe 'GET study_root_path' do
    before { get study_root_path }

    specify { expect(response).to be_successful }
  end

  describe 'GET study_surahs_path' do
    context 'when not logged in' do
      before { get study_surahs_path }

      specify { expect(response).to be_successful }
    end

    context 'when not logged in on mobile' do
      before do
        mobile_browser
        get study_surahs_path
      end

      specify { expect(response).to be_successful }
    end

    context 'when logged in' do
      before do
        login_as account
        get study_surahs_path
      end

      specify { expect(response).to be_successful }
    end

    context 'when logged in on mobile' do
      before do
        login_as account
        mobile_browser
        get study_surahs_path
      end

      specify { expect(response).to be_successful }
    end
  end

  describe 'GET /permalink' do
    before { get '/al-fatihah' }

    specify { expect(response).to be_successful }
  end

  describe 'GET study_surah_path' do
    context 'when not logged in' do
      before { get study_surah_path(1) }

      specify { expect(response).to be_successful }
    end

    context 'when not logged in on mobile' do
      before do
        mobile_browser
        get study_surah_path(1)
      end

      specify { expect(response).to be_successful }
    end

    context 'when logged in' do
      before do
        login_as account
        get study_surah_path(1)
      end

      specify { expect(response).to be_successful }
    end

    context 'when logged in on mobile' do
      before do
        login_as account
        mobile_browser
        get study_surah_path(1)
      end

      specify { expect(response).to be_successful }
    end
  end
end
