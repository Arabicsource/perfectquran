# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MailingList::Subscriber do
  let(:email) { 'email@example.com' }
  let(:hashed_email) { Digest::MD5.hexdigest email }
  let(:gibbon) { double(:gibbon) }
  let(:list) { double(:list) }
  let(:member) { double(:member) }
  let(:upsert_body) { {body: {email_address: email, status: "subscribed"}} }

  context 'when successful' do
    before do
      allow(Gibbon::Request).to receive(:new).and_return(gibbon)
      allow(gibbon).to receive(:lists).and_return(list)
      allow(list).to receive(:members).with(hashed_email).and_return(member)
      allow(member).to receive(:upsert).with(upsert_body)
    end

    specify { expect(MailingList::Subscriber.new(email).subscribe).to be_successful }
  end

  context 'when exception is raised' do
    before do
      allow(Gibbon::Request).to receive(:new).and_return(gibbon)
      allow(gibbon).to receive(:lists).and_return(list)
      allow(list).to receive(:members).with(hashed_email).and_return(member)
      allow(member).to receive(:upsert).with(upsert_body).and_raise('Exception')
    end
    
    specify { expect(MailingList::Subscriber.new(email).subscribe).not_to be_successful }
    specify { expect(MailingList::Subscriber.new(email).subscribe.error).to eq 'Exception' }
  end
end
