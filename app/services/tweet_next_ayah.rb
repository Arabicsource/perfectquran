class TweetNextAyah

  def initialize
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = Rails.application.secrets.twitter_consumer_key
      config.consumer_secret     = Rails.application.secrets.twitter_consumer_secret
      config.access_token        = Rails.application.secrets.twitter_access_token
      config.access_token_secret = Rails.application.secrets.twitter_access_token_secret
    end
  end

  def call
    tweet_next_ayah
    update_share
  end

  private

  def tweet_next_ayah
    @client.update(next_ayah_text)
  end

  def update_share
    Share.create!(ayah_id: next_ayah_id)
  end

  def next_ayah_text
    text = next_ayah.texts.where(quran_id: 3).first.content
    text = text.gsub(/\(.*?\)/, "") # removes parentheses
    text = text.gsub(/\[.*?\]/, "") # removes square brackets
    text = text.gsub('. .', '.')
    text = text.gsub(' .', '.')
    text = text.gsub(' ,', ',')
    text = text.gsub('  ', ' ')
    text = text.gsub(',,', ',')
    text = text.gsub('&#8217;', "'")
    text = text.truncate(100)
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
    last_id = Share.maximum(:id).to_i

    if last_id > 0
      return Share.find(last_id).ayah_id + 1
    else
      return 1
    end
  end
end