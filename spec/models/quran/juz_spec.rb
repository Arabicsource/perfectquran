# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Quran::Juz, type: :model do
  let(:juz_1) { Quran::Juz.first }

  describe 'associations' do
    it { is_expected.to have_many :ayahs }
    it { is_expected.to have_many :pages }
  end

  specify 'description' do
    expect(juz_1.description).to eq 'Al-Fatihah: 1 - Al-Baqarah: 141'
  end

  specify 'to_s' do
    expect(juz_1.to_s).to eq 'Juz 1'
  end
end
