# frozen_string_literal: true

# :nodoc:
module AyahsHelper

  def ayah_audio_file(surah_id, ayah_number)
    '/audios/ayahs/' + "%03d" % surah_id + "%03d" % ayah_number + '.mp3'
  end
end
