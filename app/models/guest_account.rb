class GuestAccount
  def patron?
    false
  end

  def memorized_percentage(from: nil)
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

  def group_memories_by_day_from(range_start, range_end = Time.now)
    0
  end
end