require 'rails_helper'

RSpec.describe State, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to :country }
  end

  describe 'country_name' do
    let(:country) { create :country, name: 'country123' }
    let(:state) { create :state, country: country }

    specify { expect(state.country_name).to eq 'country123' }
  end
end
