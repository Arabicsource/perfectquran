# frozen_string_literal: true

class Account
  class EmailPreferencesController < Account::BaseController
    before_action :set_email_prefrence

    def edit; end

    def update
      @email_preference.general = email_preference_params[:general]
      @email_preference.daily_ayah = email_preference_params[:daily_ayah]

      update_general_email_preference
      update_daily_ayah_email_preference

      @email_preference.save
      flash[:success] = 'Your email preferences have been updated'
      redirect_to edit_account_email_preference_path
    end

    private

    def update_general_email_preference
      return unless @email_preference.general_changed?

      if @email_preference.general
        result = MailingList::Updater.new(current_account.email).subscribe
        @email_preference.general = false unless result.successful?
      else
        result = MailingList::Updater.new(current_account.email).unsubscribe
        @email_preference.general = true unless result.successful?
      end
    end

    def update_daily_ayah_email_preference
      return unless @email_preference.daily_ayah_changed?

      if @email_preference.daily_ayah
        result = MailingList::Updater.new(current_account.email)
                                     .subscribe_to_daily_ayah
        @email_preference.daily_ayah = false unless result.successful?
      else
        result = MailingList::Updater.new(current_account.email)
                                     .unsubscribe_from_daily_ayah
        @email_preference.daily_ayah = true unless result.successful?
      end
    end

    def set_email_prefrence
      @email_preference = current_account.email_preference
    end

    def email_preference_params
      params.require(:account_email_preference).permit(:general, :daily_ayah)
    end
  end
end
