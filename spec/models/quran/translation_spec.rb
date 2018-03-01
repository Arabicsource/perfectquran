# frozen_string_literal: true

# == Schema Information
#
# Table name: quran_translations
#
#  id          :integer          not null, primary key
#  name        :string
#  description :string
#  language_id :integer
#

require 'rails_helper'

RSpec.describe Translation, type: :model do
  it { is_expected.to belong_to :language }

  describe '#available_for_posting' do
    before do
      create :translation, id: 1, name: 'first'
      create :translation, id: 2, name: 'second'
      create :translation, id: 3, name: 'third'
      create :translation, id: 4, name: 'fourth'
    end

    specify do
      expect(Translation.available_for_posting.map(&:name)).to(
        eq %w[first third]
      )
    end
  end
end
