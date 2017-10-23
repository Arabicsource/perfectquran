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
  subject { FactoryGirl.build(:user) }

  it { is_expected.to be_valid }
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_length_of(:name).is_at_least(3).is_at_most(50) }
  it { is_expected.to validate_presence_of :username }
  it { is_expected.to validate_uniqueness_of(:username).case_insensitive }
  it { is_expected.to allow_value('username').for :username }
  it { is_expected.to allow_value('username1').for :username }
  it { is_expected.to allow_value('user_name').for :username }
  it { is_expected.to_not allow_value('user name').for :username }
  it { is_expected.to have_many(:roles).through :rolings }

  describe 'User.all' do
    it 'returns users ordered by id desc' do
      FactoryGirl.create(:user, name: 'first')
      FactoryGirl.create(:user, name: 'second')
      FactoryGirl.create(:user, name: 'third')

      expect(User.all.map(&:name)).to eq %w[third second first]
    end
  end

  describe '#role?(:role)' do
    context 'admin' do
      let(:admin) { FactoryGirl.create(:admin) }

      it 'returns true when asking if role is admin' do
        expect(admin.role?(:admin)).to be_truthy
      end

      it 'returns false when asking if role is member' do
        expect(admin.role?(:member)).to be_falsey
      end

      it 'returns false when asking if role is validating' do
        expect(admin.role?(:validating)).to be_falsey
      end
    end

    context 'validating' do
      let(:validating) { FactoryGirl.create(:user) }

      it 'returns false when asking if role is admin' do
        expect(validating.role?(:admin)).to be_falsey
      end

      it 'returns false when asking if role is member' do
        expect(validating.role?(:member)).to be_falsey
      end

      it 'returns true when asking if role is validating' do
        expect(validating.role?(:validating)).to be_truthy
      end
    end

    context 'member' do
      let(:member) { FactoryGirl.create(:member) }

      it 'returns false when asking if role is admin' do
        expect(member.role?(:admin)).to be_falsey
      end

      it 'returns true when asking if role is member' do
        expect(member.role?(:member)).to be_truthy
      end

      it 'returns false when asking if role is validating' do
        expect(member.role?(:validating)).to be_falsey
      end
    end
  end

  describe '#role' do
    it 'returns Admin for administrators' do
      admin = FactoryGirl.create(:admin)

      expect(admin.role).to eq 'Admin'
    end

    it 'returns Member for confirmed users' do
      member = FactoryGirl.create(:member)

      expect(member.role).to eq 'Member'
    end

    it 'returns Validating for unconfirmed users' do
      validating = FactoryGirl.create(:user)

      expect(validating.role).to eq 'Validating'
    end
  end
end
