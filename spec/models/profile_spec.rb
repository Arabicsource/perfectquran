# frozen_string_literal: true

# == Schema Information
#
# Table name: profiles
#
#  id         :integer          not null, primary key
#  name       :string
#  username   :string
#  bio        :text
#  account_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Profile, type: :model do
  context 'validations' do
    it { is_expected.to validate_length_of(:name).is_at_most(50) }
    it { is_expected.to validate_length_of(:username).is_at_most(50) }
    it do
      is_expected.to(
        validate_uniqueness_of(:username).case_insensitive.allow_blank
      )
    end
    it { is_expected.to allow_value('username').for :username }
    it { is_expected.to allow_value('username1').for :username }
    it { is_expected.to allow_value('user_name').for :username }
    it { is_expected.to_not allow_value('user name').for :username }
    it { is_expected.to validate_length_of(:bio).is_at_most(500) }
  end
end
