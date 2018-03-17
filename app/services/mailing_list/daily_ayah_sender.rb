# frozen_string_literal: true

module MailingList
  class DailyAyahSender
    LIST_ID = Rails.application.secrets.mailchimp_list_id
    SEGMENT_ID = 12_583
    TEMPLATE_ID = 84_755

    def initialize
      @gibbon = Gibbon::Request.new
    end

    def call
      campaign = gibbon.campaigns.create(body: campaign_body)
      campaign_id = campaign.body['id']

      gibbon.campaigns(campaign_id).content.upsert(body: content_body)
      gibbon.campaigns(campaign_id).actions.send.create

      DailyAyah.create!(ayah_id: ayah.id)
    end

    private

    attr_reader :gibbon

    def settings
      {
        subject_line: title,
        title: title,
        from_name: 'PerfectQuran',
        reply_to: 'quran.is.perfect@gmail.com'
      }
    end

    def recipients
      {
        list_id: LIST_ID,
        segment_opts: {
          saved_segment_id: SEGMENT_ID
        }
      }
    end

    def campaign_body
      {
        type: 'regular',
        recipients: recipients,
        settings: settings
      }
    end

    def content_body
      { template: {
        id: TEMPLATE_ID,
        sections:
          {
            "ayah_title": "#{ayah.surah_name} #{ayah.number}",
            "uthmani_text": ayah.uthmani_text,
            "noble_text": ayah.noble_quran_text,
            "link": link
          }
      } }
    end

    # def campaign_id
    #   campaign = gibbon.campaigns.create(body: campaign_body)
    #   campaign.body['id']
    # end

    def title
      "Daily Ayah: #{ayah.surah_name} #{ayah.number}"
    end

    def link
      "<a href='https://perfectquran.co/#{ayah.surah_id}/#{ayah.number}' target='_blank'>View On PerfectQuran</a>"
    end

    def ayah
      ayah_id = DailyAyah.last.try(:ayah_id).to_i

      ayah = if ayah_id.zero? || ayah_id == 6236
               Ayah.first
             else
               Ayah.find(ayah_id + 1)
             end

      ayah
    end
  end
end
