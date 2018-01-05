# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TwitterConnectionPoster do
  let(:account) { create :account }
  let(:connection) { create :connection, account: account }
  let(:translation) { create :translation, id: 3 }
  let(:ayah) { create :ayah, id: 1 }
  let!(:text) { create :text, translation: translation, ayah: ayah }

  context 'when successful' do
    it 'returns true' do
      allow_any_instance_of(TwitterPoster).to receive(:run!).and_return(true)

      expect(TwitterConnectionPoster.new(connection).run!).to be_truthy
    end

    it 'updates connection' do
      expect { TwitterConnectionPoster.new(connection).run! }.to(
        change(connection, :last_ayah_id).from(0).to(1)
      )
    end
  end

  context 'when failure' do
    it 'returns false' do
      allow_any_instance_of(TwitterPoster).to(
        receive(:run!).and_raise('Exception')
      )

      expect(TwitterConnectionPoster.new(connection).run!).to be_falsey
    end

    it 'does not update connection' do
      allow_any_instance_of(TwitterPoster).to(
        receive(:run!).and_raise('Exception')
      )

      expect { TwitterConnectionPoster.new(connection).run! }.not_to(
        change(connection, :last_ayah_id)
      )
    end
  end
end
