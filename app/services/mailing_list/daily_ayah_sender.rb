# frozen_string_literal: true

module MailingList
  class DailyAyahSender
    LIST_ID = Rails.application.secrets.mailchimp_list_id
    SEGMENT_ID = 12583
    TEMPLATE_ID = 84755

    def initialize
      @gibbon = Gibbon::Request.new
    end

    def call
      recipients = {
        list_id: LIST_ID,
        segment_opts: {
          saved_segment_id: SEGMENT_ID
        }
      }
 
      settings = {
        subject_line: title,
        title: title,
        from_name: "PerfectQuran",
        reply_to: "quran.is.perfect@gmail.com"
      }

      body = {
        type: "regular",
        recipients: recipients,
        settings: settings
      }

      campaign = gibbon.campaigns.create(body: body)
      campaign_id = campaign.body['id']

      body = {
        template: {
          id: TEMPLATE_ID,
          sections: {
            "ayah_title": "#{ayah.surah_name} #{ayah.number}",
            "uthmani_text": ayah.uthmani_text,
            "noble_text": ayah.noble_quran_text,
            "link": link
          }
        }
      }

      gibbon.campaigns(campaign_id).content.upsert(body: body)
      gibbon.campaigns(campaign_id).actions.send.create

      Quran::DailyAyah.create!(quran_ayah_id: ayah.id)
    end

    private

    attr_reader :gibbon

    def title
      "Daily Ayah: #{ayah.surah_name} #{ayah.number}"
    end

    def link
      "<a href=\"https://perfectquran.co/#{ayah.surah_id}/#{ayah.number}\" target=\"_blank\">View On PerfectQuran</a>"
    end

    def ayah
      ayah_id = Quran::DailyAyah.last.try(:quran_ayah_id).to_i

      ayah = if ayah_id == 0 || ayah_id == 6236
               Quran::Ayah.first
             else
              Quran::Ayah.find(ayah_id + 1)
             end

      ayah
    end
  end
end
