# frozen_string_literal: true

require 'rails_helper'

describe Admin::AccountsController, type: :request do
  let(:account) { create :account }
  let(:admin) { create :admin }
  let(:member) { create :member }

  describe 'GET admin_accounts_path' do
    context 'as guest' do
      before { get admin_accounts_path }

      specify { expect(response).to redirect_to new_account_session_path }
    end

    context 'as member' do
      before do
        login_as member
        get admin_accounts_path
      end

      specify { expect(response).to redirect_to root_path }
    end

    context 'as admin' do
      before do
        login_as admin
        get admin_accounts_path
      end

      specify { expect(response).to be_successful }
    end
  end

  describe 'GET admin_account_path' do
    context 'as guest' do
      before { get admin_account_path(account) }

      specify { expect(response).to redirect_to new_account_session_path }
    end

    context 'as member' do
      before do
        login_as member
        get admin_account_path(account)
      end

      specify { expect(response).to redirect_to root_path }
    end

    context 'as admin' do
      before do
        login_as admin
        get admin_account_path(account)
      end

      specify { expect(response).to be_successful }
    end
  end
end
