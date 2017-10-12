# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string
#  username               :string
#  bio                    :string
#

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryGirl.build(:user) }
  subject { user }

  it { is_expected.to be_valid }

  it { is_expected.to respond_to :name }
  it { is_expected.to respond_to :username }
  it { is_expected.to respond_to :bio }

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_length_of(:name).is_at_least(3).is_at_most(50) }
  it { is_expected.to validate_presence_of :username }
  it { is_expected.to validate_uniqueness_of(:username).case_insensitive }
  it { is_expected.to allow_value('username').for :username }
  it { is_expected.to allow_value('username1').for :username }
  it { is_expected.to allow_value('user_name').for :username }
  it { is_expected.to_not allow_value('user name').for :username }
  it { is_expected.to have_many :rolings }
  it { is_expected.to have_many(:roles).through :rolings }

  describe '#role?(:role)' do
    let(:admin) { FactoryGirl.create(:user, :admin) }
    let(:user) { FactoryGirl.create(:user) }
    specify { expect(admin.role?(:admin)).to be_truthy }
    specify { expect(user.role?(:admin)).to be_falsey }
  end
end
