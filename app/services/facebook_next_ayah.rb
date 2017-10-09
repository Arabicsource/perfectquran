class FacebookNextAyah
  
    def initialize
      @page_graph = Koala::Facebook::API.new(Rails.application.secrets.facebook_page_token)
    end
  
    def call
      facebook_next_ayah
      update_facebook_share
    end
  
    private
  
    def facebook_next_ayah
      @page_graph.put_wall_post(next_ayah_text)
    end
  
    def update_facebook_share
      FacebookShare.create!(ayah_id: next_ayah_id)
    end
  
    def next_ayah_text
      text = next_ayah.texts.where(quran_id: 3).first.content
      text + ' ' + next_ayah_reference + ' ' + next_ayah_url
    end
  
    def next_ayah_reference
      "[#{next_ayah.surah.id}:#{next_ayah.number}]"
    end
  
    def next_ayah_url
      "https://perfectquran.co/#{next_ayah.surah.id}/#{next_ayah.number}"
    end
  
    def next_ayah
      @ayah ||= Ayah.find(next_ayah_id)
    end
  
    def next_ayah_id
      last_id = FacebookShare.maximum(:id).to_i
  
      if last_id > 0
        return FacebookShare.find(last_id).ayah_id + 1
      else
        return 1
      end
    end
  end