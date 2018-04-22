# frozen_string_literal: true

# == Schema Information
#
# Table name: states
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  code       :string
#  country_id :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

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
