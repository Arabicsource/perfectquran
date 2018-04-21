# frozen_string_literal: true

require 'rails_helper'

RSpec.describe State, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to :country }
  end

  describe 'country_code' do
    let(:country) { create :country, code: 'abc123' }
    let(:state) { create :state, country: country }

    specify { expect(state.country_code).to eq 'abc123' }
  end

  describe 'country_name' do
    let(:country) { create :country, name: 'country123' }
    let(:state) { create :state, country: country }

    specify { expect(state.country_name).to eq 'country123' }
  end
end
