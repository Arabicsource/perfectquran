# frozen_string_literal: true

module MailingList
  class Subscriber
    LIST_ID = '3821a40607'

    def initialize(email)
      @email = email
      @gibbon = Gibbon::Request.new
    end

    def subscribe
      begin
        subscribe_to_mailchimp
        success_response
      rescue => exception
        failure_response(exception.message)
      end
    end

    private

    attr_reader :email, :gibbon

    def success_response
      OpenStruct.new(successful?: true)
    end

    def failure_response(message)
      OpenStruct.new(successful?: false, error: message)
    end

    def md5_hashed_email
      Digest::MD5.hexdigest @email
    end

    def subscribe_to_mailchimp
      gibbon.lists(LIST_ID)
            .members(md5_hashed_email)
            .upsert(body: {email_address: email, status: "subscribed"})
    end
  end
end
