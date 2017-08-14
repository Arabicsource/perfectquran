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
#

require 'rails_helper'

RSpec.describe Ayah, type: :model do
  
  before { @ayah = FactoryGirl.build(:ayah) }

  specify { expect(@ayah).to be_valid }
  specify { expect(@ayah).to respond_to :number }
  specify { expect(@ayah).to respond_to :character_length }
  specify { expect(@ayah).to respond_to :percent_of_total }
  specify { expect(@ayah).to respond_to :percent_of_surah }
  specify { expect(@ayah).to respond_to :surah }
  specify { expect(@ayah).to respond_to :texts }

  specify { expect(@ayah).to belong_to :surah }
  specify { expect(@ayah).to have_many :texts }
  specify { expect(@ayah).to have_many :favorites }
end