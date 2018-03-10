# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PatronSubscriber do
  let(:stripe_helper) { StripeMock.create_test_helper }
  let(:token) { stripe_helper.generate_card_token }
  let(:plan) { stripe_helper.create_plan id: 'plan' }
  let(:account) { create :account }

  context 'when successful' do
    it 'creates a subscription' do
      expect { PatronSubscriber.new(account, token, plan.id).call }.to(
        change(Subscription, :count).by(1)
      )
    end

    it 'creates a charge' do
      expect { PatronSubscriber.new(account, token, plan.id).call }.to(
        change(Charge, :count).by(1)
      )
    end
  end

  context 'when failure' do
    before { StripeMock.prepare_card_error(:card_declined, :new_customer) }

    it 'returns false' do
      expect(PatronSubscriber.new(account, token, plan.id).call).to be_falsey
    end

    it 'does not create a subscription' do
      expect { PatronSubscriber.new(account, token, plan.id).call }.not_to(
        change(Subscription, :count)
      )
    end

    it 'does not create a charge' do
      expect { PatronSubscriber.new(account, token, plan.id).call }.not_to(
        change(Charge, :count)
      )
    end
  end
end
