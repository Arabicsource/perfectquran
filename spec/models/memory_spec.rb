# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Memory, type: :model do
  context 'associations' do
    it { is_expected.to belong_to(:ayah) }
    it { is_expected.to belong_to :account }
  end
end
