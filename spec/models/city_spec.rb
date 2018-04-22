# frozen_string_literal: true

# == Schema Information
#
# Table name: cities
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  code       :string
#  state_id   :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe City, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to :state }
  end

  describe 'state_name' do
    let(:city) { create :city, state: state }
    let(:state) { create :state, name: 'state123' }

    specify { expect(city.state_name).to eq 'state123' }
  end

  describe 'state_code' do
    let(:city) { create :city, state: state }
    let(:state) { create :state, code: 'ST123' }

    specify { expect(city.state_code).to eq 'ST123' }
  end

  describe 'country_code' do
    let(:city) { create :city, state: state }
    let(:country) { create :country, code: 'abc123' }
    let(:state) { create :state, country: country }

    specify { expect(city.country_code).to eq 'abc123' }
  end
end
