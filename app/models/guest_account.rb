# frozen_string_literal: true

class GuestAccount
  def patron?
    false
  end

  def memorized_percentage(*)
    0
  end

  def memorized_ayahs_count
    0
  end

  def memorized_surahs_count
    0
  end

  def memorized_pages_count
    0
  end

  def memorized_juzs_count
    0
  end

  def guest?
    true
  end

  def group_memories_by_day_from(*)
    0
  end

  def account_translations
    []
  end

  def translations
    []
  end
end
