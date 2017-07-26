module SurahsHelper

	def breadcrumb(surah)
		content_tag(:div, class: "breadcrumb") do
			breadcrumb = link_to "Home", root_url
			breadcrumb += " / "
			breadcrumb += content_tag(:span, surah.transliterated_name)
		end
	end

  def previous_next_links(surah)
    content_tag(:nav) do
      previous_next_links = link_to("Previous", surah.previous.permalink, class: "button") + "\n"
      previous_next_links += link_to "Next", surah.next.permalink, class: "button"
    end
  end
end
