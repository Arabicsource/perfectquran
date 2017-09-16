# frozen_string_literal: true

require 'rails_helper'

describe 'Ayahs' do
  let(:ayah) { FactoryGirl.create(:ayah) }
  let(:user) { FactoryGirl.create(:user, :confirmed) }

  describe 'GET ayah_by_number_path' do
    context 'geust' do
      before { get ayah_by_number_path(ayah.surah.id, ayah.number) }
      specify { expect(response).to be_successful }
    end

    context 'registered user' do
      before do
        login_as user
        get ayah_by_number_path(ayah.surah.id, ayah.number)
      end
      specify { expect(response).to be_successful }
    end
  end
end
