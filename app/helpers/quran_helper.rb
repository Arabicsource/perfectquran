# frozen_string_literal: true

# :nodoc:
module QuranHelper
  def bookmarked?(resource)
    Quran::Bookmark.where(bookmarkable: resource, account: current_account).any?
  end

  def bookmarks
    Quran::Bookmark.includes(:bookmarkable).where(account: current_account)
  end
end
