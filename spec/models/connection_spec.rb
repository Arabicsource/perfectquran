# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Connection, type: :model do
  let(:account) { create :account }
  let(:connection) { create :connection }

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

  describe 'hashtags' do
    it 'Adds a # to the begining' do
      connection.update_attributes(hashtags: 'tag')

      expect(connection.hashtags).to eq '#tag'
    end

    it 'is not more than 60 characters including the added #' do
      connection.update_attributes(hashtags: 'a' * 59)

      expect(connection.valid?).to be true
    end

    it 'is not more than 60 characters including the added # too long' do
      connection.update_attributes(hashtags: 'a' * 60)

      expect(connection.valid?).to be false
    end

    it 'removes spaces' do
      connection.update_attributes(hashtags: '#Tag with Space')

      expect(connection.hashtags).to eq '#TagwithSpace'
    end
  end

  context '#account_name' do
    let!(:profile) { create :profile, name: 'name123', account: account }
    let(:connection) { create :connection, account: account }

    specify { expect(connection.account_name).to eq 'name123' }
  end

  context '#last_ayah_reference' do
    context 'connection has not posted previously' do
      specify { expect(connection.last_ayah_reference).to eq '[0:0]' }
    end

    context 'connection has previously posted' do
      let(:connection) { create :connection, last_ayah_id: 7 }

      specify { expect(connection.last_ayah_reference).to eq '[1:7]' }
    end
  end

  context '#create_with_omniauth!' do
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

  describe 'daily_active' do
    before do
      create :connection, frequency: :daily, active: true, name: 'con_one'
      create :connection, frequency: :daily, active: false, name: 'con_two'
      create :connection, frequency: :daily, active: true, name: 'con_three'
    end

    specify do
      expect(Connection.daily_active.map(&:name)).to eq %w[con_one con_three]
    end
  end

  describe 'daily_active' do
    before do
      create :connection, frequency: :hourly, active: true, name: 'con_one'
      create :connection, frequency: :hourly, active: false, name: 'con_two'
      create :connection, frequency: :hourly, active: true, name: 'con_three'
    end

    specify do
      expect(Connection.hourly_active.map(&:name)).to eq %w[con_one con_three]
    end
  end

  context '#all_active' do
    before do
      create :connection, frequency: :hourly, active: true, name: 'con_one'
      create :connection, frequency: :hourly, active: false, name: 'con_two'
      create :connection, frequency: :daily, active: true, name: 'con_three'
    end

    specify do
      expect(Connection.all_active.map(&:name)).to eq %w[con_one con_three]
    end
  end
end
