# frozen_string_literal: true

require 'rails_helper'

RSpec.describe QuranHelper, type: :helper do
  let(:ayah) { Quran::Ayah.first }
  let(:member) { create :member }

  describe 'bookmarked?' do
    context 'as guest' do
      specify { expect(helper.bookmarked?(ayah)).to be false }
    end

    context 'as member' do
      context 'when not bookmarked' do
        specify { expect(helper.bookmarked?(ayah, member)).to be false }
      end

      context 'when bookmarked' do
        before { create :bookmark, account: member, ayah: ayah }

        specify { expect(helper.bookmarked?(ayah, member)).to be true }
      end
    end
  end
end
