# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Connection, type: :model do
  fixtures :translations

  context 'associations' do
    it { is_expected.to belong_to :account }
    it { is_expected.to belong_to :translation }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :provider }
    it { is_expected.to validate_presence_of :provider_uid }
    it { is_expected.to validate_presence_of :token }
    it { is_expected.to validate_presence_of :secret }

    it do
      is_expected.to validate_uniqueness_of(:provider_uid).scoped_to(:provider)
    end
  end

  describe 'enums' do
    it do
      is_expected.to(
        define_enum_for(:frequency).with(%i[daily hourly])
      )
    end
  end

  context '#account_name' do
    let!(:profile) { create :profile, name: 'name123', account: account }
    let(:account) { create :account }
    let(:connection) do
      create(
        :connection, account: account, translation: translations(:translation_1)
      )
    end

    specify { expect(connection.account_name).to eq 'name123' }
  end

  context '#last_ayah_reference' do
    context 'connection has not posted previously' do
      let(:connection) do
        create :connection, translation: translations(:translation_1)
      end

      specify { expect(connection.last_ayah_reference).to eq '[0:0]' }
    end

    context 'connection has previously posted' do
      let(:connection) do
        create(
          :connection,
          last_ayah_id: 7,
          translation: translations(:translation_1)
        )
      end

      specify { expect(connection.last_ayah_reference).to eq '[1:7]' }
    end
  end

  context '#create_with_omniauth!' do
    let(:account) { create :account }

    let(:auth_hash) do
      {
        uid: 'uid12345',
        info: { nickname: 'nickname' },
        credentials: { token: 'token', secret: 'secret' }
      }
    end

    specify do
      expect { Connection.create_with_omniauth!(auth_hash, account) }.to(
        change(Connection, :count).by(1)
      )
    end
  end

  context 'scopes' do
    context '#all_active' do
      let(:account) { create :account }

      let!(:first_active) do
        create(
          :connection,
          provider_uid: '12345',
          active: true,
          account: account,
          translation: translations(:translation_1)
        )
      end

      let!(:second_inactive) do
        create(
          :connection,
          provider_uid: '67890',
          account: account,
          translation: translations(:translation_1)
        )
      end

      let!(:third_active) do
        create(
          :connection,
          provider_uid: 'abcdef',
          active: true,
          account: account,
          translation: translations(:translation_1)
        )
      end

      it 'returns active' do
        expect(Connection.all_active.size).to eq 2
      end
    end
  end
end
