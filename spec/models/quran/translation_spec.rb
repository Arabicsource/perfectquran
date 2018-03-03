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
    specify do
      expect(Translation.available_for_posting.map(&:name)).to(
        eq ['Uthmani', 'The Noble Quran']
      )
    end
  end
end
