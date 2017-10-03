# frozen_string_literal: true

# :nodoc:
module SurahsHelper
  def breadcrumb(surah)
    content_tag(:div, class: 'breadcrumb') do
      link_to('Home', root_url) +
        ' / ' +
        content_tag(:span, surah.transliterated_name)
    end
  end

  def previous_next_links(surah)
    content_tag(:nav) do
      link_to('Previous',
              surah.previous.permalink,
              class: 'button button-primary') +
        "\n" +
        link_to('Next', surah.next.permalink, class: 'button button-primary')
    end
  end

  def ayah_is_favorited?(user, ayah)
    Favorite.find_by(user_id: user.id, ayah_id: ayah.id) unless user.nil?
  end

  def ayah_is_memorized?(user, ayah)
    Memory.find_by(user_id: user.id, ayah_id: ayah.id) unless user.nil?
  end

  def surah_audio_file(surah_id)
    '/audios/' + "%03d" % surah_id + '.mp3'
  end
end
