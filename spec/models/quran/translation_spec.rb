# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Quran::Translation, type: :model do
  it { is_expected.to belong_to :language }

  describe '#available_for_posting' do
    specify do
      expect(Quran::Translation.available_for_posting.map(&:name)).to(
        eq ['Uthmani', 'The Noble Quran', 'Yusuf Ali']
      )
    end
  end
end
