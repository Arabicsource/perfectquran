# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MemoriesHelper, type: :helper do
  describe '#memorized?' do
    it 'returns true if account has memorized the ayah' do
      account = create :account
      ayah = create :ayah
      create :memory, ayah: ayah, account: account

      expect(helper.memorized?(ayah, account)).to be_truthy
    end

    it 'returns false if account has not memorized the ayah' do
      account = create :account
      ayah = create :ayah

      expect(helper.memorized?(ayah, account)).to be_falsey
    end
  end
end
