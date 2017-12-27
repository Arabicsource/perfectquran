# frozen_string_literal: true

require 'rails_helper'

describe 'quran/surahs/show' do
  let(:title) { surah.transliterated_name }
  let(:surah) { build_stubbed :surah }
  let(:account) { build_stubbed :account }

  before do
    allow(surah).to receive(:previous).and_return(build_stubbed(:surah))
    allow(surah).to receive(:next).and_return(build_stubbed(:surah))
    allow(view).to receive(:current_account).and_return(account)
    allow(view).to receive(:account_signed_in?).and_return(false)
    assign :surah, surah
  end

  it_behaves_like 'a titled view'
end
