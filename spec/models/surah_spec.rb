# == Schema Information
#
# Table name: surahs
#
#  id                  :integer          not null, primary key
#  number_of_ayahs     :integer
#  order_of_revelation :integer
#  revelation_type     :integer
#  permalink           :string
#  transliterated_name :string
#  arabic_name         :string
#  english_name        :string
#  character_length    :integer
#  percent_of_total    :float
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

require 'rails_helper'

RSpec.describe Surah, type: :model do
  
  before { @surah = FactoryGirl.build(:surah) }

  specify { expect(@surah).to be_valid }
  specify { expect(@surah).to respond_to :number_of_ayahs }
  specify { expect(@surah).to respond_to :order_of_revelation }
  specify { expect(@surah).to respond_to :revelation_type }
  specify { expect(@surah).to respond_to :permalink }
  specify { expect(@surah).to respond_to :transliterated_name }
  specify { expect(@surah).to respond_to :arabic_name }
  specify { expect(@surah).to respond_to :english_name }
  specify { expect(@surah).to respond_to :character_length }
  specify { expect(@surah).to respond_to :percent_of_total }
  specify { expect(@surah).to respond_to :ayahs }

  specify { expect(@surah).to have_many(:ayahs).order('id asc') }
  specify { expect(@surah).to define_enum_for(:revelation_type).with([:meccan, :medinan]) }

  describe "#next" do
    before { @surahs = FactoryGirl.create_list(:surah, 5) }
    specify "returns the next surah" do 
      first_surah = @surahs.first
      expect(first_surah.next).to eq(@surahs[1])
    end

    specify "returns first surah if current surah is last" do
      expect(@surahs.last.next).to eq(@surahs[0])
    end
  end

  describe "#previous" do
    before { @surahs = FactoryGirl.create_list(:surah, 3) }

    specify "returns the previous surah" do
      expect(@surahs.last.previous).to eq(@surahs[1])
    end

    specify "returns the last surah if the current surah is first" do
      expect(@surahs.first.previous).to eq(@surahs.last)
    end
 end
end