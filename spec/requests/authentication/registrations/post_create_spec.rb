# frozen_string_literal: true

require 'rails_helper'

describe 'Registration POST #create', type: :request do
  it 'increases user count by 1 when successful' do
    expect { post '/', params: { account: attributes_for(:account) } }
      .to change(Account, :count).by(1)
  end

  it 'does not change user count when unsuccessful' do
    expect { post '/', params: { account: { name: '' } } }
      .not_to change(Account, :count)
  end

  context 'empty submission' do
    before(:all) { post '/', params: { account: { name: '' } } }

    it 'includes email can\'t be blank' do
      expect(response.body).to include 'Email can&#39;t be blank'
    end

    it 'includes password can\'t be blank' do
      expect(response.body).to include 'Password can&#39;t be blank'
    end

    it 'includes name can\'t be blank' do
      expect(response.body).to include 'Name can&#39;t be blank'
    end

    it 'includes name is too short' do
      expect(response.body).to include 'Name is too short'
    end

    it 'includes username can\'t be blank' do
      expect(response.body).to include 'Username can&#39;t be blank'
    end

    it 'includes username character limitations' do
      expect(response.body).to include 'sername only Letters, numbers'
    end
  end
end
