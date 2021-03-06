# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TwitterConnectionPoster do
  let(:account) { create :account }
  let(:translation) { Quran::Translation.find_by(id: 3) }
  let(:ayah) { Ayah.first }

  context 'when successful' do
    let(:connection) do
      create :connection, account: account
    end

    it 'returns true' do
      allow_any_instance_of(TwitterPoster).to receive(:call).and_return(true)

      expect(TwitterConnectionPoster.new(connection).call).to be_truthy
    end

    it 'updates connection' do
      expect { TwitterConnectionPoster.new(connection).call }.to(
        change(connection, :last_ayah_id).from(0).to(1)
      )
    end
  end

  context 'when last ayah' do
    let(:connection) do
      create(
        :connection,
        account: account,
        last_ayah_id: 6236
      )
    end

    specify do
      expect(TwitterConnectionPoster.new(connection).call).to be_truthy
    end
  end

  context 'when middle ayah' do
    let(:connection) do
      create(
        :connection, account: account, last_ayah_id: 5, translation: translation
      )
    end

    specify do
      expect(TwitterConnectionPoster.new(connection).call).to be_truthy
    end
  end

  context 'when failure' do
    let(:connection) { create :connection, account: account }

    before do
      allow_any_instance_of(TwitterPoster).to(
        receive(:call).and_raise('Exception')
      )
    end

    it 'returns false' do
      expect(TwitterConnectionPoster.new(connection).call).to be_falsey
    end

    it 'does not update connection' do
      expect { TwitterConnectionPoster.new(connection).call }.not_to(
        change(connection, :last_ayah_id)
      )
    end
  end
end
