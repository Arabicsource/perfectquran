# frozen_string_literal: true

module ApplicationHelper
  def page_title(title = '')
    base_title = 'Perfect Quran'
    return base_title if title.empty?
    "#{title} | #{base_title}"
  end

  def markdown(text)
    options = { autolink: true }
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, options)
    markdown.render(text).html_safe
  end

  def short_ordinal(date_column)
    date_column.to_date.to_formatted_s(:short_ordinal)
  end

  def account_patron?
    current_account&.patron?
  end
end
