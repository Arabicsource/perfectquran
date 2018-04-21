# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mosque, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to :city }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :name }
  end

  describe 'city_name' do
    let(:city) { create :city, name: 'city123' }
    let(:mosque) { create :mosque, city: city }

    specify { expect(mosque.city_name).to eq 'city123' }
  end

  describe 'state_code' do
    let(:city) { create :city, state: state }
    let(:mosque) { create :mosque, city: city }
    let(:state) { create :state, code: 'ST123' }

    specify { expect(mosque.state_code).to eq 'ST123' }
  end

  describe 'country_code' do
    let(:city) { create :city, state: state }
    let(:country) { create :country, code: 'CC123' }
    let(:mosque) { create :mosque, city: city }
    let(:state) { create :state, country: country }

    specify { expect(mosque.country_code).to eq 'CC123' }
  end

  describe 'location' do
    let(:city) { create :city, state: state }
    let(:country) { create :country, code: 'CC' }
    let(:mosque) { create :mosque, city: city }
    let(:state) { create :state, country: country }

    specify { expect(mosque.location).to eq 'City, ST, CC' }
  end

  describe 'to_param' do
    let(:mosque) { create :mosque, id: 1, name: 'Mosque 123' }

    specify { expect(mosque.to_param).to eq '1-mosque-123' }
  end
end
