module AyahsHelper
    
    # Most Favorited Ayahs
    def most_favorited_ayahs
        content_tag :section, class: "most-favorited-ayahs" do
            html = content_tag :h1, "Most Favorited Ayahs"
            html += content_tag :ul do
                ayahs = ""
                Ayah.order("favorites_count DESC").limit(5).each do |ayah|
                    name = ayah.surah.transliterated_name
                    number = ayah.number
                    count = ayah.favorites_count
                    ayahs += link_to("#{name}:#{number} (#{count})", 
                        surah_path(ayah.surah.permalink, anchor: "ayah-#{ayah.id}"))
                end
                ayahs.html_safe
            end
            html
        end
    end
end