# frozen_string_literal: true

module QuranHelper
  def bookmarked?(ayah, account = nil)
    Quran::Bookmark.where(ayah: ayah, account: account).any?
  end

  def bookmarks
    Bookmark.includes(:bookmarkable).where(account: current_account)
  end
end
