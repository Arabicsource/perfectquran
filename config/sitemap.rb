# frozen_string_literal: true

# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = 'https://perfectquran.co'

SitemapGenerator::Sitemap.create do
  Quran::Surah.find_each do |surah|
    add quran_surah_path(surah), changefreq: 'monthly'

    surah.ayahs.each do |ayah|
      add quran_ayah_path(surah, ayah.number), changefreq: 'monthly'
    end
  end
end
