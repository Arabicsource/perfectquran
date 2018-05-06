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
    it { is_expected.to have_many :mosques }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :code }
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

  describe 'country_*' do
    let(:city) { create :city, state: state }
    let(:country) { create :country, name: 'name123', code: 'abc123' }
    let(:state) { create :state, country: country }

    specify { expect(city.country_name).to eq 'name123' }
    specify { expect(city.country_code).to eq 'abc123' }
  end

  describe 'to_s' do
    let(:city) { create :city, name: 'city123', code: 'CI' }

    specify { expect(city.to_s).to eq 'City: city123 (CI)' }
  end
end
