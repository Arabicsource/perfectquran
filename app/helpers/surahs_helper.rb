module SurahsHelper

	def breadcrumb(surah)
		content_tag(:div, class: "breadcrumb") do
			breadcrumb = link_to "Home", root_url
			breadcrumb += " / "
			breadcrumb += content_tag(:span, surah.transliterated_name)
		end
	end
end
