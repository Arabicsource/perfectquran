# frozen_string_literal: true

# :nodoc:
module SurahsHelper
  def ayah_is_favorited?(user, ayah)
    Favorite.find_by(user_id: user.id, ayah_id: ayah.id) unless user.nil?
  end

  def ayah_is_memorized?(user, ayah)
    Memory.find_by(user_id: user.id, ayah_id: ayah.id) unless user.nil?
  end

  def surah_audio_file(surah_id)
    format('/audios/%03d.mp3', surah_id)
  end
end
