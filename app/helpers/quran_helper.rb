# frozen_string_literal: true

# :nodoc:
module QuranHelper
  def bookmarked?(resource)
    Quran::Bookmark.where(bookmarkable: resource, account: current_account).any?
  end
end
