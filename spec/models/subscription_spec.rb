# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Subscription, type: :model do
  context 'associations' do
    it { is_expected.to belong_to :account }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of :customer_token }
    it { is_expected.to validate_presence_of :subscription_token }
    it { is_expected.to validate_presence_of :status }
    it { is_expected.to validate_presence_of :payment_brand }
    it { is_expected.to validate_presence_of :payment_last4 }
    it { is_expected.to validate_presence_of :current_period_end }
  end

  describe '.active?' do
    context 'with active status' do
      let(:subscription) { build_stubbed(:subscription, status: 'active') }

      it 'returns true' do
        expect(subscription.active?).to be_truthy
      end
    end

    context 'with inactive status' do
      let(:subscription) { build_stubbed(:subscription, status: 'cancelled') }

      it 'returns false' do
        expect(subscription.active?).to be_falsey
      end
    end
  end

  describe '.cancelled?' do
    context 'with active status' do
      let(:subscription) { build_stubbed(:subscription, status: 'active') }

      it 'returns false' do
        expect(subscription.cancelled?).to be_falsey
      end
    end

    context 'with inactive status' do
      let(:subscription) { build_stubbed(:subscription, status: 'cancelled') }

      it 'returns true' do
        expect(subscription.cancelled?).to be_truthy
      end
    end
  end
end
