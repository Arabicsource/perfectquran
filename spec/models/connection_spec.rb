# frozen_string_literal: true

# == Schema Information
#
# Table name: connections
#
#  id           :integer          not null, primary key
#  name         :string
#  provider     :string
#  provider_uid :string
#  token        :string
#  secret       :string
#  account_id   :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  status       :integer
#

require 'rails_helper'

RSpec.describe Connection, type: :model do
  context 'associations' do
    it { is_expected.to belong_to :account }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :provider }
    it { is_expected.to validate_presence_of :provider_uid }
    it { is_expected.to validate_presence_of :token }
    it { is_expected.to validate_presence_of :secret }
    it { is_expected.to validate_presence_of :status }

    it do
      is_expected.to validate_uniqueness_of(:provider_uid).scoped_to(:provider)
    end
  end

  context 'enums' do
    it { is_expected.to define_enum_for(:status).with(%i[inactive active]) }
  end
end
