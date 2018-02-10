# frozen_string_literal: true

require 'rails_helper'

describe 'POST account_email_preference_path', type: :request do
  let(:subscriber) { double(:subscriber) }
  let(:unsubscriber) { double(:unsubscriber) }
  let(:failure_response) { OpenStruct.new(successful?: false) }
  let(:successful_response) { OpenStruct.new(successful?: true) }
  let(:email_preference) { account.email_preference }
  let(:account) { create :account }
  let(:url) { account_email_preference_path }

  let(:invalid_params) do
    { account_email_preference: { general: '' } }
  end

  let(:valid_params) do
    { account_email_preference: { general: true } }
  end

  context 'without account' do
    it 'redirects to the login page' do
      patch url, params: valid_params

      expect(response).to redirect_to new_account_session_path
    end
  end

  context 'with account' do
    before { login_as account }

    context 'when subscribing to general is successful' do
      before do
        email_preference.toggle!(:general)

        expect(MailingList::Updater).to(
          receive(:new).with(account.email).and_return(subscriber)
        )

        expect(subscriber).to(
          receive(:subscribe).and_return(successful_response)
        )

        expect { patch url, params: valid_params }
          .to change{email_preference.reload.general}
      end

      specify do
        expect(response).to redirect_to edit_account_email_preference_path
      end

      specify do
        expect(email_preference.general).to be_truthy
      end
    end

    context 'when subscribing to general is unsuccessful' do
      before do
        email_preference.toggle!(:general)

        expect(MailingList::Updater).to(
          receive(:new).with(account.email).and_return(subscriber)
        )

        expect(subscriber).to(
          receive(:subscribe).and_return(failure_response)
        )

        expect { patch url, params: valid_params }
          .not_to change{email_preference.reload.general}
      end

      specify do
        expect(response).to redirect_to edit_account_email_preference_path
      end

      specify do
        expect(email_preference.general).to be_falsey
      end
    end

    context 'when unsubscribing to general is successful' do
      before do
        expect(MailingList::Updater).to(
          receive(:new).with(account.email).and_return(unsubscriber)
        )

        expect(unsubscriber).to(
          receive(:unsubscribe).and_return(successful_response)
        )

        expect { patch url, params: { account_email_preference: { general: false } } }
          .to change{email_preference.reload.general}
      end

      specify do
        expect(response).to redirect_to edit_account_email_preference_path
      end

      specify do
        expect(email_preference.general).to be_falsey
      end
    end

    context 'when unsubscribing to general is unsuccessful' do
      before do
        expect(MailingList::Updater).to(
          receive(:new).with(account.email).and_return(unsubscriber)
        )

        expect(unsubscriber).to(
          receive(:unsubscribe).and_return(failure_response)
        )

        expect { patch url, params: { account_email_preference: { general: false } } }
          .not_to change{email_preference.reload.general}
      end

      specify do
        expect(response).to redirect_to edit_account_email_preference_path
      end

      specify do
        expect(email_preference.general).to be_truthy
      end
    end
  end
end
