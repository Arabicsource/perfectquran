module ApplicationHelper

  def page_title(title="")
    base_title = 'Perfect Quran'

    return base_title if title.empty?
    return "#{title} | #{base_title}"
  end

  def markdown(text)
    options = { filter_html: true, no_images: true, no_styles: true, safe_links_only: true, hard_wrap: true }
    renderer = Redcarpet::Render::HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer)
    markdown.render(text).html_safe
  end
end
