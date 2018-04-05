# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Quran::Page, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to :juz }
    it { is_expected.to have_many :ayahs }
  end

  describe 'next' do
    specify { expect(Quran::Page.second.next).to eq Quran::Page.third }
    specify { expect(Quran::Page.last.next).to eq(Quran::Page.first) }
  end

  describe 'previous' do
    specify { expect(Quran::Page.second.previous).to eq Quran::Page.first }
    specify { expect(Quran::Page.first.previous).to eq(Quran::Page.last) }
  end

  specify 'description' do
    expect(Quran::Page.first.description).to eq 'Page 1'
  end

  specify 'to_s' do
    expect(Quran::Page.first.to_s).to eq 'Page 1'
  end
end
