# frozen_string_literal: true

require 'rails_helper'

describe 'GET Quran::Memories#new', type: :request do
  context 'as a guest' do
    it 'redirects the guest to the login page' do
      get new_quran_memory_path

      expect(response).to redirect_to new_account_session_path
    end
  end

  context 'as a basic account' do
    it 'responds successfully' do
      create :surah
      login_as create :account

      get new_quran_memory_path

      expect(response).to be_successful
    end
  end
end
