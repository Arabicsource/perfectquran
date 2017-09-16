# frozen_string_literal: true

# :nodoc:
class AyahFacade
  def initialize(surah_id, number, user)
    @ayah = Ayah.find_by(surah_id: surah_id, number: number)
    @user = user
  end

  def id
    @ayah.id
  end

  def memory_id
    return 0 unless @user
    memory.id
  end

  def memory
    @memory ||= Memory.find_or_initialize_by(
      ayah_id: @ayah.id, user_id: @user.id
    )
  end

  def memorized?
    memory.persisted?
  end

  def memory_count
    @ayah.memories.count
  end

  def favorite_id
    return 0 unless @user
    favorite.id
  end

  def favorite
    @favorite ||= Favorite.find_or_initialize_by(
      ayah_id: @ayah.id, user_id: @user.id
    )
  end

  def favorited?
    favorite.persisted?
  end

  def favorite_count
    @ayah.favorites.count
  end

  def surah_name
    @ayah.surah.transliterated_name
  end

  def surah_permalink
    @ayah.surah.permalink
  end

  def number
    @ayah.number
  end

  def previous?
    @ayah.previous?
  end

  def previous
    @ayah.previous
  end

  def next?
    @ayah.next?
  end

  def next
    @ayah.next
  end

  def texts
    @ayah.texts.includes(:quran).ordered_by_quran_id
  end
end
