# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MailingList::Updater do
  let(:email) { 'email@example.com' }
  let(:hashed_email) { Digest::MD5.hexdigest email }
  let(:gibbon) { double(:gibbon) }
  let(:list) { double(:list) }
  let(:member) { double(:member) }
  let(:subscribe_body) { {body: {email_address: email, status: "subscribed"}} }
  let(:unsubscribe_body) { {body: {email_address: email, status: "unsubscribed"}} }
  let(:unsubscribe_body) { {body: {email_address: email, status: "unsubscribed"}} }
  let(:subscribe_to_daily_ayah_body) { { body: {interests: {'dailyayahid' => true} } } }

  before do
    allow(Gibbon::Request).to receive(:new).and_return(gibbon)
    allow(gibbon).to receive(:lists).and_return(list)
    allow(list).to receive(:members).with(hashed_email).and_return(member)
  end

  context 'when subscribing' do
    before { expect(member).to receive(:upsert).with(subscribe_body) }

    specify do
      expect(MailingList::Updater.new(email).subscribe).to be_successful
    end
  end

  context 'when subscribing with exception' do
    before do
      expect(member).to(
        receive(:upsert).with(subscribe_body).and_raise('Exception')
      )
    end
    
    specify do
      expect(MailingList::Updater.new(email).subscribe)
        .not_to be_successful
    end

    specify do
      expect(MailingList::Updater.new(email).subscribe.error)
        .to eq 'Exception'
    end
  end

  context 'when unsubscribing' do
    before { expect(member).to receive(:upsert).with(unsubscribe_body) }

    specify do
      expect(MailingList::Updater.new(email).unsubscribe)
        .to be_successful
    end
  end

  context 'when unsubscribing with exception' do
    before do
      expect(member)
        .to receive(:upsert).with(unsubscribe_body).and_raise('Exception')
    end
    
    specify do
      expect(MailingList::Updater.new(email).unsubscribe)
        .not_to be_successful
    end

    specify do
      expect(MailingList::Updater.new(email).unsubscribe.error)
        .to eq 'Exception'
    end
  end

  context 'when subscribing to daily ayah' do
    before { expect(member).to receive(:upsert).with(subscribe_to_daily_ayah_body) }

    specify do
      expect(MailingList::Updater.new(email).subscribe_to_daily_ayah).to be_successful
    end
  end
end
