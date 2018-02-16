# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TwitterPoster do
  let(:token) { 'token' }
  let(:secret) { 'secret' }
  let(:text) { 'text' }

  context 'when successful' do
    before do
      allow_any_instance_of(Twitter::REST::Client).to(
        receive(:update).with(text)
      )
    end

    specify do
      expect(TwitterPoster.new(token, secret, text).call).to be_successful
    end
  end

  context 'when failure' do
    before do
      allow_any_instance_of(Twitter::REST::Client).to(
        receive(:update).with(text).and_raise('Exception')
      )
    end

    specify do
      expect(TwitterPoster.new(token, secret, text).call).not_to be_successful
    end

    specify do
      expect(TwitterPoster.new(token, secret, text).call.error)
        .to eq('Exception')
    end
  end
end
