# frozen_string_literal: true

# == Schema Information
#
# Table name: mosques
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  phone      :string
#  email      :string
#  street     :string
#  city       :string
#  state      :string
#  country    :string
#  zip_code   :string
#  website    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  city_id    :bigint(8)
#

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

  describe 'state_*' do
    let(:city) { create :city, state: state }
    let(:mosque) { create :mosque, city: city }
    let(:state) { create :state, name: 'state123', code: 'ST123' }

    specify { expect(mosque.state_code).to eq 'ST123' }
    specify { expect(mosque.state_name).to eq 'state123' }
  end

  describe 'country_*' do
    let(:city) { create :city, state: state }
    let(:country) { create :country, name: 'Country123', code: 'CC123' }
    let(:mosque) { create :mosque, city: city }
    let(:state) { create :state, country: country }

    specify { expect(mosque.country_code).to eq 'CC123' }
    specify { expect(mosque.country_name).to eq 'Country123' }
  end

  describe 'location' do
    let(:city) { create :city, state: state }
    let(:country) { create :country, code: 'CC' }
    let(:mosque) { create :mosque, city: city }
    let(:state) { create :state, country: country }

    specify { expect(mosque.location).to eq 'City, ST, CC' }
  end

  describe 'to_*' do
    let(:mosque) { create :mosque, id: 1, name: 'Mosque 123' }

    specify { expect(mosque.to_param).to eq '1-mosque-123' }
    specify { expect(mosque.to_s).to eq 'Mosque: Mosque 123' }
  end
end
