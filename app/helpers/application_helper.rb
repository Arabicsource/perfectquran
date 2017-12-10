# frozen_string_literal: true

# :nodoc:
module ApplicationHelper
  def page_title(title = '')
    base_title = 'Perfect Quran'
    return base_title if title.empty?
    "#{title} | #{base_title}"
  end

  def menu(menu_name, label = nil)
    menu = Menu.find_by(name: menu_name)
    return if menu.nil?
    label ||= menu_name

    render 'shared/menu', label: label, links: menu.menu_links
  end

  def markdown(text)
    options = { autolink: true }
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, options)
    markdown.render(text).html_safe
  end
end
