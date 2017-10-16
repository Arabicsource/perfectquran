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
  before { @ayah = FactoryGirl.build(:ayah) }

  specify { expect(@ayah).to be_valid }
  specify { expect(@ayah).to respond_to :number }
  specify { expect(@ayah).to respond_to :character_length }
  specify { expect(@ayah).to respond_to :percent_of_total }
  specify { expect(@ayah).to respond_to :percent_of_surah }
  specify { expect(@ayah).to respond_to :surah }
  specify { expect(@ayah).to respond_to :texts }
  specify { expect(@ayah).to respond_to :comments }

  specify { expect(@ayah).to belong_to :surah }
  specify { expect(@ayah).to have_many :texts }
  specify { expect(@ayah).to have_many :favorites }
  specify { expect(@ayah).to have_many :memories }
  specify { expect(@ayah).to have_many :comments }  

  describe '#visible_comments?' do
    it 'is false when no comments exisit' do
      expect(@ayah.visible_comments?).to be_falsey
    end

    it 'is false when all comments have been flagged' do
      ayah_with_flagged_comments = FactoryGirl.create(:ayah, :with_flagged_comments)
      expect(ayah_with_flagged_comments.visible_comments?).to be_falsey
    end

    it 'is true when no comments have been flagged' do
      ayah_with_comments = FactoryGirl.create(:ayah, :with_comments)
      expect(ayah_with_comments.visible_comments?).to be_truthy
    end

    it 'is true when there is a mixture of flagged and unflagged comments' do
      ayah_with_mixed_commments = FactoryGirl.create(:ayah, :with_mixed_comments)
      expect(ayah_with_mixed_commments.visible_comments?).to be_truthy
    end

    it 'is true when comments have been approved' do
      ayah_with_approved_comments = FactoryGirl.create(:ayah, :with_approved_comments)
      expect(ayah_with_approved_comments.visible_comments?).to be_truthy
    end
  end

  describe '#previous?' do
    it 'is false if ayah number is one' do
      @ayah.number = 1
      expect(@ayah.previous?).to be_falsey
    end

    it 'is true if ayah number is greater than one' do
      @ayah.number = 2
      expect(@ayah.previous?).to be_truthy
    end
  end

  describe '#previous' do
    it 'returns the previous ayah' do
      expect(ayahs.second.previous).to eq(ayahs.first)
    end
  end

  describe '#next?' do
    it 'is false if ayah number is equal to number of ayahs in surah' do
      @ayah.number = @ayah.surah.number_of_ayahs
      expect(@ayah.next?).to be_falsey
    end

    it 'is true if ayah number is less than the number of ayahs in surah' do
      @ayah.number = @ayah.surah.number_of_ayahs - 1
      expect(@ayah.next?).to be_truthy
    end
  end

  describe '#next' do
    it 'returns the next ayah' do
      expect(ayahs.second.next).to eq(ayahs.third)
    end
  end
end
