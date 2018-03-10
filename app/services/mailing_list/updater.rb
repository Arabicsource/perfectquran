# frozen_string_literal: true

module MailingList
  class Updater
    LIST_ID = Rails.application.secrets.mailchimp_list_id
    DAILY_AYAH_ID = Rails.application.secrets.mailchimp_daily_ayah_id

    def initialize(email)
      @gibbon = Gibbon::Request.new
      @email = email
    end

    def subscribe
      update_mailing_list(subscribe_message)
    end

    def unsubscribe
      update_mailing_list(unsubscribe_message)
    end

    def subscribe_to_daily_ayah
      update_mailing_list(subscribe_to_daily_ayah_message)
    end

    def unsubscribe_from_daily_ayah
      update_mailing_list(unsubscribe_from_daily_ayah_message)
    end

    private

    attr_reader :gibbon, :email

    def update_mailing_list(message_body)
      gibbon.lists(LIST_ID)
            .members(md5_hashed_email)
            .upsert(message_body)
      success_response
    rescue StandardError => exception
      failure_response(exception.message)
    end

    def subscribe_message
      { body: { email_address: email, status: 'subscribed' } }
    end

    def unsubscribe_message
      { body: { email_address: email, status: 'unsubscribed' } }
    end

    def subscribe_to_daily_ayah_message
      { body: { interests: { DAILY_AYAH_ID => true } } }
    end

    def unsubscribe_from_daily_ayah_message
      { body: { interests: { DAILY_AYAH_ID => false } } }
    end

    def success_response
      OpenStruct.new(successful?: true)
    end

    def failure_response(message)
      OpenStruct.new(successful?: false, error: message)
    end

    def md5_hashed_email
      Digest::MD5.hexdigest email
    end
  end
end
