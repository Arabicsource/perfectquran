# frozen_string_literal: true

module AyahsHelper
  def ayah_audio_file(surah_id, ayah_number)
    format('/audios/ayahs/%03d%03d.mp3', surah_id, ayah_number)
  end
end
