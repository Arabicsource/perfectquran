# frozen_string_literal: true

require 'rails_helper'

describe 'Registration POST #create', type: :request do
  let(:valid_params) { { account: attributes_for(:account) } }
  let(:invalid_params) { { account: { email: '' } } }

  it 'increases user count by 1 when successful' do
    expect { post account_registration_path, params: valid_params }
      .to change(Account, :count).by(1)
  end

  it 'does not change user count when unsuccessful' do
    expect { post account_registration_path, params: invalid_params }
      .not_to change(Account, :count)
  end

  context 'empty submission' do
    before(:all) do
      post account_registration_path, params: { account: { email: '' } }
    end

    it 'includes email can\'t be blank' do
      expect(response.body).to include 'Email can&#39;t be blank'
    end

    it 'includes password can\'t be blank' do
      expect(response.body).to include 'Password can&#39;t be blank'
    end
  end
end
