# frozen_string_literal: true

require 'rails_helper'

describe 'quran/ayahs/show' do
  let(:account) { build_stubbed :account }
  let(:ayah) { build_stubbed :ayah }
  let(:title) { "#{ayah.surah_name} #{ayah.number}" }

  before do
    allow(view).to receive(:account_signed_in?).and_return(false)
    allow(view).to receive(:current_account).and_return(account)
    assign :ayah, ayah
  end

  it_behaves_like 'a titled view'
end
