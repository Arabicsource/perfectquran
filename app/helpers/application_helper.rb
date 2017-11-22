# frozen_string_literal: true

# :nodoc:
module ApplicationHelper
  def page_title(title = '')
    base_title = 'Perfect Quran'
    return base_title if title.empty?
    "#{title} | #{base_title}"
  end
end
