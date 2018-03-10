# frozen_string_literal: true

module SurahsHelper
  def surah_audio_file(surah_id)
    format('/audios/%03d.mp3', surah_id)
  end
end
