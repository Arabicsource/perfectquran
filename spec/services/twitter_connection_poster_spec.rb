# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TwitterConnectionPoster do
  let(:account) { create :account }
  let(:translation) { create :translation, id: 3 }
  let(:ayah) { create :ayah, id: 1 }

  context 'when successful' do
    let(:connection) { create :connection, account: account }
    let!(:text) { create :text, translation: translation, ayah: ayah }

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

  context 'when last ayah' do
    let(:ayah) { create :ayah, id: 1 }
    let!(:text) { create :text, translation: translation, ayah: ayah }

    let(:connection) do
      create :connection, account: account, last_ayah_id: 6236
    end

    specify do
      expect(TwitterConnectionPoster.new(connection).run!).to be_truthy
    end
  end

  context 'when middle ayah' do
    let(:connection) { create :connection, account: account, last_ayah_id: 5 }
    let(:ayah) { create :ayah, id: 6 }
    let!(:text) { create :text, translation: translation, ayah: ayah }

    specify do
      expect(TwitterConnectionPoster.new(connection).run!).to be_truthy
    end
  end

  context 'when failure' do
    let(:connection) { create :connection, account: account }
    let!(:text) { create :text, translation: translation, ayah: ayah }

    before do
      allow_any_instance_of(TwitterPoster).to(
        receive(:run!).and_raise('Exception')
      )
    end

    it 'returns false' do
      expect(TwitterConnectionPoster.new(connection).run!).to be_falsey
    end

    it 'does not update connection' do
      expect { TwitterConnectionPoster.new(connection).run! }.not_to(
        change(connection, :last_ayah_id)
      )
    end
  end
end