# frozen_string_literal: true

# == Schema Information
#
# Table name: countries
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  code       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Country, type: :model do
  describe 'associations' do
    it { is_expected.to have_many :states }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :code }
  end

  describe 'to_s' do
    let(:country) { create :country, name: 'country123', code: 'CO' }

    specify { expect(country.to_s).to eq 'Country: country123 (CO)' }
  end
end
