# frozen_string_literal: true

# :nodoc:
module ApplicationHelper
  def page_title(title = '')
    base_title = 'Perfect Quran'
    return base_title if title.empty?
    "#{title} | #{base_title}"
  end

  def markdown(text)
    options = {
      filter_html: true, no_images: true, no_styles: true,
      safe_links_only: true, hard_wrap: true, autolink: true,
      strikethrough: true, underline: true
    }
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, options)
    markdown.render(text).html_safe
  end
end
