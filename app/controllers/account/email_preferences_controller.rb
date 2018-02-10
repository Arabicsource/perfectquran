# frozen_string_literal: true

class Account
  # :nodoc:
  class EmailPreferencesController < Account::BaseController
    def edit
      @email_preference = current_account.email_preference
    end

    def update
      @email_preference = current_account.email_preference
      @email_preference.general = email_preference_params[:general]
      @email_preference.daily_ayah = email_preference_params[:daily_ayah]

      if @email_preference.general_changed?
        if @email_preference.general
          result = MailingList::Updater.new(current_account.email).subscribe
          @email_preference.general = false unless result.successful?
        else
          result = MailingList::Updater.new(current_account.email).unsubscribe
          @email_preference.general = true unless result.successful?
        end
      end

      if @email_preference.daily_ayah_changed?
        if @email_preference.daily_ayah
          result = MailingList::Updater.new(current_account.email).subscribe_to_daily_ayah
          @email_preference.daily_ayah = false unless result.successful?
        else
          result = MailingList::Updater.new(current_account.email).unsubscribe_from_daily_ayah
          @email_preference.daily_ayah = true unless result.successful?
        end
      end

      @email_preference.save
      flash[:success] = 'Your email preferences have been updated'
      redirect_to edit_account_email_preference_path
    end

    private

    def email_preference_params
      params.require(:account_email_preference).permit(:general, :daily_ayah)
    end
  end
end
