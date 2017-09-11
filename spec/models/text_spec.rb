# frozen_string_literal: true

# == Schema Information
#
# Table name: texts
#
#  id         :integer          not null, primary key
#  content    :text
#  quran_id   :integer
#  ayah_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Text, type: :model do
  before { @text = FactoryGirl.build(:text) }

  specify { expect(@text).to be_valid }
  specify { expect(@text).to respond_to :content }
  specify { expect(@text).to respond_to :quran }
  specify { expect(@text).to respond_to :ayah }

  specify { expect(@text).to belong_to(:quran) }
  specify { expect(@text).to belong_to :ayah }

  describe '#uthmani?' do
    it 'is false if text.quran is not uthmani' do
      @text.quran_id = 2
      expect(@text.uthmani?).to be_falsey
    end

    it 'is true if text.quran is uthmani' do
      @text.quran_id = 1
      expect(@text.uthmani?).to be_truthy
    end
  end
end
