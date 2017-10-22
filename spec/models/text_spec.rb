# frozen_string_literal: true

# == Schema Information
#
# Table name: texts
#
#  id             :integer          not null, primary key
#  content        :text
#  translation_id :integer
#  ayah_id        :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'rails_helper'

RSpec.describe Text, type: :model do
  subject { Text.first }

  it { is_expected.to be_valid }
  it { is_expected.to belong_to :translation }
  it { is_expected.to belong_to :ayah }

  describe '#uthmani?' do
    it 'returns false if translation_id is not 1' do
      subject.translation_id = 2
      expect(subject.uthmani?).to be_falsey
    end

    it 'returns true if translation_id is 1' do
      subject.translation_id = 1
      expect(subject.uthmani?).to be_truthy
    end
  end
end
