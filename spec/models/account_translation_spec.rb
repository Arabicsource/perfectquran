# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AccountTranslation, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to :account }
    it { is_expected.to belong_to :translation }
  end
end
