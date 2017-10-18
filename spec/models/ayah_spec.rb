# frozen_string_literal: true

# == Schema Information
#
# Table name: ayahs
#
#  id               :integer          not null, primary key
#  number           :integer
#  character_length :integer
#  percent_of_total :float
#  percent_of_surah :float
#  surah_id         :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  favorites_count  :integer          default(0)
#  memories_count   :integer          default(0)
#

require 'rails_helper'

RSpec.describe Ayah, type: :model do
  let(:ayahs) { FactoryGirl.create_list(:ayah, 5) }  
  subject { FactoryGirl.build_stubbed(:ayah) }

  it { is_expected.to be_valid }
  it { is_expected.to belong_to :surah }
  it { is_expected.to have_many :texts }
  it { is_expected.to have_many :favorites }
  it { is_expected.to have_many :memories }
  it { is_expected.to have_many :comments }

  it_behaves_like 'commentable'

  describe '#redirect_path' do
    specify { expect(subject.redirect_path).to eq "/#{subject.surah.id}/#{subject.number}" }
  end

  describe '#previous?' do
    it 'is false if ayah number is one' do
      subject.number = 1
      expect(subject.previous?).to be_falsey
    end

    it 'is true if ayah number is greater than one' do
      subject.number = 2
      expect(subject.previous?).to be_truthy
    end
  end

  describe '#previous' do
    it 'returns the previous ayah' do
      expect(ayahs.second.previous).to eq(ayahs.first)
    end
  end

  describe '#next?' do
    it 'is false if ayah number is equal to number of ayahs in surah' do
      subject.number = subject.surah.number_of_ayahs
      expect(subject.next?).to be_falsey
    end

    it 'is true if ayah number is less than the number of ayahs in surah' do
      subject.number = subject.surah.number_of_ayahs - 1
      expect(subject.next?).to be_truthy
    end
  end

  describe '#next' do
    it 'returns the next ayah' do
      expect(ayahs.second.next).to eq(ayahs.third)
    end
  end
end
