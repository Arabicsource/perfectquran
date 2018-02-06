# frozen_string_literal: true

require 'rails_helper'
require 'digest'

describe '/devise/registrations/create', type: :request do
  let(:valid_params) do
    { account:
      { email: 'example@example.com',
        password: 'password',
        password_confirmation: 'password' } }
  end

  context 'without account' do
    it 'redirects' do
      allow_any_instance_of(Account).to receive(:subscribe_to_newsletter).and_return(true)
      post '/', params: valid_params
      expect(response).to redirect_to accounts_root_path
    end

    it 'creates account' do
      allow_any_instance_of(Account).to receive(:subscribe_to_newsletter).and_return(true)
      expect { post '/', params: valid_params }.to change(Account, :count).by(1)
    end

    it 'creates profile' do
      allow_any_instance_of(Account).to receive(:subscribe_to_newsletter).and_return(true)
      expect { post '/', params: valid_params }.to change(Profile, :count).by(1)
    end

    it 'sends an email' do
      allow_any_instance_of(Account).to receive(:subscribe_to_newsletter).and_return(true)
      expect { post '/', params: valid_params }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end

    it 'subscribes account email to mailing list' do
      gibbon = double(Gibbon::Request)
      list = double(:list)
      member = double(:member)
      hashed_email = Digest::MD5.hexdigest 'example@example.com'

      expect(member).to receive(:upsert).with(body: {email_address: 'example@example.com', status: "subscribed"})
      expect(list).to receive(:members).with(hashed_email).and_return(member)
      expect(gibbon).to receive(:lists).and_return(list)
      expect(Gibbon::Request).to receive(:new).and_return(gibbon)

      post '/', params: valid_params
    end
  end
end
