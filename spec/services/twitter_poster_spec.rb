# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TwitterPoster do
  let(:token) { 'token' }
  let(:secret) { 'secret' }
  let(:text) { 'text' }

  context 'when successful' do
    it 'returns true' do
      allow_any_instance_of(Twitter::REST::Client).to(
        receive(:update).with(text).and_return(true)
      )

      expect(TwitterPoster.new(token, secret, text).run!).to be_truthy
    end
  end

  context 'when failure' do
    it 'returns false' do
      allow_any_instance_of(Twitter::REST::Client).to(
        receive(:update).with(text).and_raise('Exception')
      )

      expect(TwitterPoster.new(token, secret, text).run!).to be_falsey
    end
  end
end
