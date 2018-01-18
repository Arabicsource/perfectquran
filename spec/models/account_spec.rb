# frozen_string_literal: true

# == Schema Information
#
# Table name: accounts
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
#  role                   :string           default("validating")
#

require 'rails_helper'

RSpec.describe Account, type: :model do
  context 'associations' do
    it { is_expected.to have_one :profile }
    it { is_expected.to have_one :subscription }
    it { is_expected.to have_many :connections }
    it { is_expected.to have_many :memories }
  end

  describe '#patron?' do
    context 'with subscription' do
      let(:account) { create :account, :with_subscription }
      specify { expect(account.patron?).to be_truthy }
    end

    context 'without subscription' do
      let(:account) { create :account }
      specify { expect(account.patron?).to be_falsey }
    end
  end

  describe '#name' do
    context 'when profile has name' do
      it 'returns profile name' do
        account = create :account
        account.profile.update_attribute :name, 'name123'

        expect(account.name).to eq 'name123'
      end
    end

    context 'when profile has no name' do
      it 'returns annon' do
        account = create :account

        expect(account.name).to eq 'Anonymous'
      end
    end
  end

  describe '#after_confirmation' do
    it 'changes the users role to member' do
      validating = create :validating
      validating.confirm
      validating.reload

      expect(validating.role).to eq 'member'
    end
  end

  describe '#after_create' do
    it 'creates profile' do
      expect { create :account }.to change(Profile, :count).by(1)
    end
  end

  describe 'Account.all' do
    it 'returns users ordered by id desc' do
      FactoryBot.create(:account, email: 'first@example.com')
      FactoryBot.create(:account, email: 'second@example.com')
      FactoryBot.create(:account, email: 'third@example.com')

      expect(Account.all.map(&:email)).to(
        eq %w[third@example.com second@example.com first@example.com]
      )
    end
  end

  describe '#role?(:role)' do
    context 'admin' do
      let(:admin) { FactoryBot.create(:admin) }

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
      let(:validating) { FactoryBot.create(:account) }

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
      let(:member) { FactoryBot.create(:member) }

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
end
